# frozen_string_literal: true

module ImageGeneration
  class Client
    def initialize(configuration: Configuration.new,
                   prompt_loader: PromptLoader.new,
                   reference_image_builder: ReferenceImageBuilder.new,
                   provider_registry: nil)
      @configuration = configuration
      @prompt_loader = prompt_loader
      @reference_image_builder = reference_image_builder
      @provider_registry = provider_registry || ProviderRegistry.new(configuration: configuration)
    end

    def generate(template:, attributes:, reference_image_signed_ids: [], reference_image_paths: [], provider: nil)
      prompt = prompt_loader.load(template, attributes: attributes)

      # Build reference images from both sources
      reference_images_from_storage = reference_image_builder.build(reference_image_signed_ids)
      reference_images_from_paths = reference_image_builder.build_from_paths(reference_image_paths)
      reference_images = reference_images_from_storage + reference_images_from_paths

      resolved_provider = provider_registry.resolve(provider || configuration.provider_name)

      usable_reference_images = if resolved_provider.respond_to?(:supports_reference_images?) &&
                                   !resolved_provider.supports_reference_images?
                                  Rails.logger.info do
                                    {
                                      event: "image_generation.reference_images.skipped",
                                      provider: resolved_provider.class.name,
                                      skipped_count: reference_images.size
                                    }
                                  end
                                  []
                                else
                                  reference_images
                                end

      Rails.logger.info do
        {
          event: "image_generation.generate",
          template: template,
          provider: resolved_provider.class.name,
          attribute_keys: attributes.keys,
          reference_count: usable_reference_images.size
        }
      end

      resolved_provider.generate(prompt: prompt, reference_images: usable_reference_images)
    end

    private

    attr_reader :configuration, :prompt_loader, :reference_image_builder, :provider_registry
  end
end
