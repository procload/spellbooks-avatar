# frozen_string_literal: true

module ImageGeneration
  class ProviderRegistry
    class UnknownProviderError < StandardError; end

    def initialize(configuration: Configuration.new, providers: {})
      @configuration = configuration
      @providers = providers
    end

    def resolve(name = configuration.provider_name)
      provider_key = name.to_sym
      providers[provider_key] ||= build_provider(provider_key)
    end

    private

    attr_reader :configuration, :providers

    def build_provider(name)
      case name
      when :gemini
        Providers::Gemini.new(config: configuration.provider_config(:gemini))
      else
        raise UnknownProviderError, "Image generation provider '#{name}' is not supported"
      end
    end
  end
end
