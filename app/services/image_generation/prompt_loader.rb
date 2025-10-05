# frozen_string_literal: true

require "erb"

module ImageGeneration
  class PromptLoader
    Prompt = Struct.new(:system_prompt, :text, :example_images, keyword_init: true)

    class MissingTemplateError < StandardError; end

    def initialize(loader: nil)
      @loader = loader || method(:load_config)
    end

    def load(template_name, attributes: {})
      template_config = fetch_template(template_name)
      context = PromptContext.new(attributes)
      prompt_text = render_template(template_config.fetch("user_prompt_template"), context)
      example_images = Array(template_config["example_images"]).map do |example|
        example.to_h.stringify_keys
      end
      prompt_text = append_example_images(prompt_text, example_images) if example_images.any?

      Prompt.new(
        system_prompt: template_config["system_prompt"],
        text: prompt_text,
        example_images: example_images
      )
    end

    private

    attr_reader :loader

    def fetch_template(template_name)
      raw_template = loader.call(template_name.to_s)
      raise MissingTemplateError, "No prompt template named '#{template_name}'" if raw_template.blank?

      raw_template.to_h.deep_stringify_keys
    end

    def load_config(template_name)
      Rails.application.config_for("prompts/#{template_name}")
    end

    def render_template(template, context)
      ERB.new(template, trim_mode: "-").result(context.get_binding)
    end

    def append_example_images(prompt_text, example_images)
      lines = example_images.map do |example|
        description = "- #{example.fetch("label")}: #{example.fetch("url")}"
        notes = example["notes"].presence
        notes ? "#{description} (#{notes})" : description
      end
      [ prompt_text, "", "Reference example images:", *lines ].join("\n")
    end

    class PromptContext
      attr_reader :inputs

      def initialize(inputs)
        @inputs = (inputs || {}).with_indifferent_access
      end

      def get_binding
        binding
      end
    end
  end
end
