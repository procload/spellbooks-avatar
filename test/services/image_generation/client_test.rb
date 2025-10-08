# frozen_string_literal: true

require "test_helper"

module ImageGeneration
  class ClientTest < ActiveSupport::TestCase
    test "generate delegates to provider with loaded prompt and reference images" do
      # Create mock objects
      mock_config = Minitest::Mock.new
      mock_config.expect :provider_name, :gemini

      mock_prompt = PromptLoader::Prompt.new(
        system_prompt: "System",
        text: "User prompt",
        example_images: []
      )

      mock_loader = Minitest::Mock.new
      mock_loader.expect :load, mock_prompt, [ "avatar" ], attributes: { persona: "mage" }

      mock_reference_images = [
        ImageGeneration::ReferenceImage.new(
          mime_type: "image/png",
          data: "base64data",
          filename: "reference.png"
        )
      ]
      mock_builder = Minitest::Mock.new
      mock_builder.expect :build, mock_reference_images, [ [ "signed_id_1" ] ]

      mock_response = Providers::Gemini::Response.new(images: [], raw: {})
      mock_provider = Minitest::Mock.new
      mock_provider.expect :generate, mock_response, [], prompt: mock_prompt, reference_images: mock_reference_images

      mock_registry = Minitest::Mock.new
      mock_registry.expect :resolve, mock_provider, [ :gemini ]

      # Create client with mocks
      client = Client.new(
        configuration: mock_config,
        prompt_loader: mock_loader,
        reference_image_builder: mock_builder,
        provider_registry: mock_registry
      )

      # Execute
      result = client.generate(
        template: "avatar",
        attributes: { persona: "mage" },
        reference_image_signed_ids: [ "signed_id_1" ],
        provider: nil
      )

      # Verify
      assert_equal mock_response, result
      mock_config.verify
      mock_loader.verify
      mock_builder.verify
      mock_provider.verify
      mock_registry.verify
    end

    test "generate uses custom provider when specified" do
      mock_config = Minitest::Mock.new

      mock_prompt = PromptLoader::Prompt.new(
        system_prompt: "System",
        text: "User prompt",
        example_images: []
      )

      mock_loader = Minitest::Mock.new
      mock_loader.expect :load, mock_prompt, [ "avatar" ], attributes: {}

      mock_builder = Minitest::Mock.new
      mock_builder.expect :build, [], [ [] ]

      mock_response = Providers::Gemini::Response.new(images: [], raw: {})
      mock_provider = Minitest::Mock.new
      mock_provider.expect :generate, mock_response, [], prompt: mock_prompt, reference_images: []

      mock_registry = Minitest::Mock.new
      mock_registry.expect :resolve, mock_provider, [ :custom_provider ]

      client = Client.new(
        configuration: mock_config,
        prompt_loader: mock_loader,
        reference_image_builder: mock_builder,
        provider_registry: mock_registry
      )

      result = client.generate(
        template: "avatar",
        attributes: {},
        reference_image_signed_ids: [],
        provider: :custom_provider
      )

      assert_equal mock_response, result
      mock_loader.verify
      mock_builder.verify
      mock_provider.verify
      mock_registry.verify
    end

    test "generate drops reference images when provider does not support them" do
      mock_config = Minitest::Mock.new

      mock_prompt = PromptLoader::Prompt.new(
        system_prompt: "System",
        text: "User prompt",
        example_images: []
      )

      mock_loader = Minitest::Mock.new
      mock_loader.expect :load, mock_prompt, [ "avatar" ], attributes: {}

      mock_builder = Minitest::Mock.new
      mock_builder.expect :build, [ :reference_image ], [ [] ]

      mock_provider = Minitest::Mock.new
      def mock_provider.supports_reference_images?
        false
      end
      mock_response = Providers::OpenAi::Response.new(images: [], raw: {})
      mock_provider.expect :generate, mock_response, [], prompt: mock_prompt, reference_images: []

      mock_registry = Minitest::Mock.new
      mock_registry.expect :resolve, mock_provider, [ :openai ]

      client = Client.new(
        configuration: mock_config,
        prompt_loader: mock_loader,
        reference_image_builder: mock_builder,
        provider_registry: mock_registry
      )

      result = client.generate(
        template: "avatar",
        attributes: {},
        reference_image_signed_ids: [],
        provider: :openai
      )

      assert_equal mock_response, result
      mock_loader.verify
      mock_builder.verify
      mock_provider.verify
      mock_registry.verify
    end
  end
end
