# frozen_string_literal: true

require "test_helper"
require "base64"
require "ostruct"
require "json"
require "faraday/multipart"

module ImageGeneration
  module Providers
    class OpenAiTest < ActiveSupport::TestCase
      setup do
        @prompt = ImageGeneration::PromptLoader::Prompt.new(
          system_prompt: "System context",
          text: "User prompt",
          example_images: []
        )
      end

      test "generate posts JSON payload to generations endpoint" do
        response_body = {
          "data" => [
            { "b64_json" => Base64.strict_encode64("image-bytes"), "mime_type" => "image/png" }
          ]
        }.to_json

        connection = CapturingConnection.new(StubResponse.new(body: response_body, status: 200))
        provider = OpenAi.new(config: base_config, connection: connection)

        result = provider.generate(prompt: @prompt, reference_images: [])

        assert_equal "generations", connection.last_request[:path]

        payload = JSON.parse(connection.last_request[:body])
        assert_equal "gpt-image-1-mini", payload["model"]
        assert_match "User prompt", payload["prompt"]

        assert_equal 1, result.images.size
        assert_equal "image/png", result.images.first.inline_data[:mime_type]
      end

      test "generate uses edits endpoint when reference images provided" do
        reference = ImageGeneration::ReferenceImage.new(
          data: Base64.strict_encode64("reference-bytes"),
          mime_type: "image/png",
          filename: "reference.png"
        )

        response_body = {
          "data" => [
            { "b64_json" => Base64.strict_encode64("image"), "mime_type" => "image/png" }
          ]
        }.to_json

        connection = CapturingConnection.new(StubResponse.new(body: response_body, status: 200))
        provider = OpenAi.new(config: base_config, connection: connection)

        result = provider.generate(prompt: @prompt, reference_images: [reference])

        assert_equal "edits", connection.last_request[:path]

        body = connection.last_request[:body]
        assert_kind_of Hash, body
        assert_equal "gpt-image-1-mini", body["model"]

        uploads = body["image"]
        assert_kind_of Array, uploads
        assert_kind_of Faraday::UploadIO, uploads.first

        assert_equal 1, result.images.size
      end

      test "generate raises provider error when request fails" do
        response_body = { "error" => { "message" => "not authorized" } }.to_json
        connection = CapturingConnection.new(StubResponse.new(body: response_body, status: 401))
        provider = OpenAi.new(config: base_config, connection: connection)

        error = assert_raises(OpenAi::Error) do
          provider.generate(prompt: @prompt, reference_images: [])
        end

        assert_includes error.message, "not authorized"
      end

      private

      def base_config
        {
          api_key: "test-key",
          endpoint: "https://api.openai.com/v1/images",
          model: "gpt-image-1-mini",
          response_format: "b64_json"
        }
      end

      class StubResponse
        attr_reader :body, :status

        def initialize(body:, status: 200)
          @body = body
          @status = status
        end

        def success?
          status.to_i.between?(200, 299)
        end
      end

      class CapturingConnection
        attr_reader :last_request

        def initialize(response)
          @response = response
        end

        def post(path)
          request = OpenStruct.new(headers: {}, body: nil)
          yield request
          @last_request = { path: path, headers: request.headers, body: request.body }
          @response
        end
      end
    end
  end
end
