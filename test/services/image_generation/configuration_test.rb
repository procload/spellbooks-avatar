# frozen_string_literal: true

require "test_helper"

module ImageGeneration
  class ConfigurationTest < ActiveSupport::TestCase
    test "provider_name returns configured provider as symbol" do
      config = Configuration.new({ "provider" => "gemini" })

      assert_equal :gemini, config.provider_name
    end

    test "provider_config returns configuration for provider" do
      raw_config = {
        "provider" => "gemini",
        "gemini" => {
          "api_key" => "test_key",
          "endpoint" => "https://api.example.com"
        }
      }
      config = Configuration.new(raw_config)

      provider_config = config.provider_config(:gemini)

      assert_equal "test_key", provider_config[:api_key]
      assert_equal "https://api.example.com", provider_config[:endpoint]
    end

    test "provider_config raises error for missing provider" do
      config = Configuration.new({ "provider" => "gemini" })

      error = assert_raises(Configuration::MissingProviderError) do
        config.provider_config(:unknown)
      end

      assert_equal "No configuration found for provider 'unknown'", error.message
    end

    test "provider_config uses provider_name by default" do
      raw_config = {
        "provider" => "gemini",
        "gemini" => { "api_key" => "default_key" }
      }
      config = Configuration.new(raw_config)

      provider_config = config.provider_config

      assert_equal "default_key", provider_config[:api_key]
    end

    test "to_h returns symbolized configuration hash" do
      raw_config = {
        "provider" => "gemini",
        "gemini" => { "api_key" => "test" }
      }
      config = Configuration.new(raw_config)

      hash = config.to_h

      assert_equal :gemini, hash[:provider]
      assert_equal "test", hash[:gemini][:api_key]
    end
  end
end
