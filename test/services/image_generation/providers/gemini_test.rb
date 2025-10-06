# frozen_string_literal: true

require "test_helper"

module ImageGeneration
  module Providers
    class GeminiTest < ActiveSupport::TestCase
      StubRequest = Struct.new(:params, :headers, :body) do
        def initialize
          super({}, {}, nil)
        end
      end

      StubResponse = Struct.new(:status, :body, keyword_init: true) do
        def success?
          (200..299).cover?(status)
        end
      end

      class StubConnection
        attr_reader :last_request, :response

        def initialize(response)
          @response = response
        end

        def post(path)
          request = StubRequest.new
          yield request
          @last_request = { path: path, params: request.params, headers: request.headers, body: request.body }
          response
        end
      end

      def test_posts_prompt_and_references
        config = {
          api_key: "secret",
          endpoint: "https://example.com/v1beta/models",
          model: "gemini-2.0-nano-banana",
          generation_config: { temperature: 0.2 },
          safety_settings: [ { category: "HARM_CATEGORY_HATE", threshold: "BLOCK_NONE" } ]
        }
        response_payload = {
          "generatedImages" => [
            { "imageUri" => "gs://image-123" }
          ]
        }
        connection = StubConnection.new(StubResponse.new(status: 200, body: JSON.generate(response_payload)))
        provider = Gemini.new(config: config, connection: connection)
        prompt = ImageGeneration::PromptLoader::Prompt.new(system_prompt: "Guide", text: "Describe avatar", example_images: [])

        result = provider.generate(
          prompt: prompt,
          reference_images: [ { inlineData: { mimeType: "image/png", data: "abc" } } ]
        )

        assert_equal "gemini-2.0-nano-banana:generateImages", connection.last_request[:path]
        assert_equal "secret", connection.last_request[:params]["key"]
        assert_equal "application/json", connection.last_request[:headers]["Content-Type"]

        body = JSON.parse(connection.last_request[:body])
        assert_equal "Guide", body.dig("systemInstruction", "parts", 0, "text")
        assert_equal "Describe avatar", body.dig("contents", 0, "parts", 0, "text")
        assert_equal "image/png", body.dig("contents", 0, "parts", 1, "inlineData", "mimeType")
        assert_equal 0.2, body.dig("generationConfig", "temperature")
        assert_equal "HARM_CATEGORY_HATE", body.dig("safetySettings", 0, "category")

        assert_equal 1, result.images.length
        assert_equal "gs://image-123", result.images.first.uri
      end

      def test_raises_when_api_key_missing
        config = {
          api_key: nil,
          endpoint: "https://example.com/v1beta/models",
          model: "gemini-2.0-nano-banana"
        }
        provider = Gemini.new(config: config, connection: StubConnection.new(StubResponse.new(status: 200, body: "{}")))
        prompt = ImageGeneration::PromptLoader::Prompt.new(system_prompt: nil, text: "Prompt", example_images: [])

        assert_raises(Gemini::Error) do
          provider.generate(prompt: prompt, reference_images: [])
        end
      end
    end
  end
end
