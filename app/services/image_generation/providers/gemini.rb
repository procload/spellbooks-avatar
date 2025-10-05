# frozen_string_literal: true

require "json"
require "faraday"

module ImageGeneration
  module Providers
    class Gemini
      class Error < StandardError; end

      Response = Struct.new(:images, :raw, keyword_init: true)
      Image = Struct.new(:uri, :inline_data, keyword_init: true)

      def initialize(config:, connection: nil)
        @config = config.deep_symbolize_keys
        @connection = connection || build_connection
      end

      def generate(prompt:, reference_images: [])
        raise Error, "Gemini API key is missing" if api_key.blank?

        response = connection.post("#{model}:generateImages") do |request|
          request.params["key"] = api_key
          request.headers["Content-Type"] = "application/json"
          request.body = JSON.generate(build_request_body(prompt, reference_images))
        end

        parsed = parse_response(response)
        Response.new(images: build_images(parsed), raw: parsed)
      rescue Faraday::Error => e
        raise Error, "Gemini request failed: #{e.message}"
      end

      private

      attr_reader :config, :connection

      def build_connection
        Faraday.new(url: endpoint) do |faraday|
          faraday.request :retry, max: 2, interval: 0.25, interval_randomness: 0.5, backoff_factor: 2
          faraday.adapter :net_http
        end
      end

      def build_request_body(prompt, reference_images)
        body = {
          contents: [
            {
              role: "user",
              parts: [
                { text: prompt.text },
                *Array(reference_images)
              ]
            }
          ]
        }
        if prompt.system_prompt.present?
          body[:systemInstruction] = { role: "system", parts: [ { text: prompt.system_prompt } ] }
        end
        generation_config = config[:generation_config]
        body[:generationConfig] = generation_config if generation_config.present?
        safety_settings = config[:safety_settings]
        body[:safetySettings] = safety_settings if safety_settings.present?
        body
      end

      def parse_response(response)
        payload = response.body.present? ? JSON.parse(response.body) : {}
        return payload if response.success?

        message = payload.dig("error", "message") || "HTTP #{response.status}"
        raise Error, "Gemini request failed: #{message}"
      end

      def build_images(payload)
        Array(payload["generatedImages"]).map do |image|
          inline = image["inlineData"]
          inline_data = if inline
            {
              data: inline["data"],
              mime_type: inline["mimeType"] || inline["mime_type"]
            }.compact
          end

          inline_data = nil if inline_data.blank?

          Image.new(
            uri: image["imageUri"],
            inline_data: inline_data
          )
        end
      end

      def endpoint
        config.fetch(:endpoint)
      end

      def model
        config.fetch(:model)
      end

      def api_key
        config[:api_key]
      end
    end
  end
end
