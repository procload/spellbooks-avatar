# frozen_string_literal: true

require "test_helper"

module ImageGeneration
  class ProviderRegistryTest < ActiveSupport::TestCase
    test "resolve returns gemini provider for :gemini" do
      mock_config = Minitest::Mock.new
      mock_config.expect :provider_config, { endpoint: "https://api.example.com", api_key: "test", model: "gemini-1.5" }, [ :gemini ]

      registry = ProviderRegistry.new(configuration: mock_config)

      provider = registry.resolve(:gemini)

      assert_instance_of Providers::Gemini, provider
      mock_config.verify
    end

    test "resolve returns openai provider for :openai" do
      mock_config = Minitest::Mock.new
      mock_config.expect :provider_config, { endpoint: "https://api.openai.com/v1/images", api_key: "test", model: "gpt-image-1-mini" }, [ :openai ]

      registry = ProviderRegistry.new(configuration: mock_config)

      provider = registry.resolve(:openai)

      assert_instance_of Providers::OpenAi, provider
      mock_config.verify
    end

    test "resolve caches provider instances" do
      mock_config = Minitest::Mock.new
      mock_config.expect :provider_config, { endpoint: "https://api.example.com", api_key: "test", model: "gemini-1.5" }, [ :gemini ]

      registry = ProviderRegistry.new(configuration: mock_config)

      provider1 = registry.resolve(:gemini)
      provider2 = registry.resolve(:gemini)

      assert_same provider1, provider2
      mock_config.verify
    end

    test "resolve uses default provider from configuration when no name given" do
      mock_config = Minitest::Mock.new
      mock_config.expect :provider_name, :gemini
      mock_config.expect :provider_config, { endpoint: "https://api.example.com", api_key: "test", model: "gemini-1.5" }, [ :gemini ]

      registry = ProviderRegistry.new(configuration: mock_config)

      provider = registry.resolve

      assert_instance_of Providers::Gemini, provider
      mock_config.verify
    end

    test "resolve raises error for unknown provider" do
      mock_config = Minitest::Mock.new

      registry = ProviderRegistry.new(configuration: mock_config)

      error = assert_raises(ProviderRegistry::UnknownProviderError) do
        registry.resolve(:unknown)
      end

      assert_equal "Image generation provider 'unknown' is not supported", error.message
    end

    test "can inject pre-built providers" do
      mock_provider = Minitest::Mock.new
      mock_config = Minitest::Mock.new

      registry = ProviderRegistry.new(
        configuration: mock_config,
        providers: { custom: mock_provider }
      )

      provider = registry.resolve(:custom)

      assert_same mock_provider, provider
    end
  end
end
