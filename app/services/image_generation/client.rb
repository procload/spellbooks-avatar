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

    def generate(template:, attributes:, reference_image_signed_ids: [], provider: nil)
      prompt = prompt_loader.load(template, attributes: attributes)
      reference_images = reference_image_builder.build(reference_image_signed_ids)
      resolved_provider = provider_registry.resolve(provider || configuration.provider_name)
      resolved_provider.generate(prompt: prompt, reference_images: reference_images)
    end

    private

    attr_reader :configuration, :prompt_loader, :reference_image_builder, :provider_registry
  end
end
