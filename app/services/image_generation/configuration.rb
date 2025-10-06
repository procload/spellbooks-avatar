# frozen_string_literal: true

module ImageGeneration
  class Configuration
    class MissingProviderError < StandardError; end

    def initialize(raw_config = Rails.application.config_for(:image_generation))
      @config = deep_symbolize(raw_config)
    end

    def provider_name
      config.fetch(:provider).to_sym
    end

    def provider_config(name = provider_name)
      config.fetch(name) do
        raise MissingProviderError, "No configuration found for provider '#{name}'"
      end
    end

    def to_h
      config
    end

    private

    attr_reader :config

    def deep_symbolize(raw)
      raw.respond_to?(:to_h) ? raw.to_h.deep_symbolize_keys : raw
    end
  end
end
