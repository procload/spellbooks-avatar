# frozen_string_literal: true

require "json"
require "base64"
require "stringio"
require "faraday"
require "faraday/retry"
require "faraday/multipart"
require "securerandom"

module ImageGeneration
  module Providers
    class OpenAi
      class Error < ImageGeneration::ProviderError; end

      Response = Struct.new(:images, :raw, keyword_init: true)
      Image = Struct.new(:uri, :inline_data, keyword_init: true)

      def initialize(config:, connection: nil)
        @config = config.deep_symbolize_keys
        @connection = connection || build_connection
      end

      def generate(prompt:, reference_images: [])
        raise Error, "OpenAI API key is missing" if api_key.blank?

        Rails.logger.info do
          {
            event: "image_generation.openai.request",
            model: model,
            endpoint: endpoint,
            reference_count: Array(reference_images).size,
            prompt_characters: prompt.text.to_s.length
          }
        end

        response = if reference_images.present?
                     connection.post("edits") do |request|
                       request.body = build_edit_payload(prompt, reference_images)
                     end
                   else
                     connection.post("generations") do |request|
                       request.headers["Content-Type"] = "application/json"
                       request.body = JSON.generate(build_generation_payload(prompt))
                     end
                   end

        parsed = parse_response(response)
        Rails.logger.info do
          {
            event: "image_generation.openai.response",
            status: response.status,
            image_count: parsed.fetch("data", []).size
          }
        end
        Response.new(images: build_images(parsed), raw: parsed)
      rescue Faraday::Error => e
        Rails.logger.error do
          {
            event: "image_generation.openai.error",
            error_class: e.class.name,
            error_message: e.message
          }
        end
        case e
        when Faraday::TimeoutError, Faraday::ConnectionFailed
          raise e
        else
          raise Error, "OpenAI request failed: #{e.message}"
        end
      end

      def supports_reference_images?
        false
      end

      private

      attr_reader :config, :connection

      def build_connection
        Faraday.new(url: endpoint) do |faraday|
          faraday.request :multipart
          faraday.request :retry, max: 2, interval: 0.25, interval_randomness: 0.5, backoff_factor: 2
          faraday.adapter :net_http
          faraday.options.timeout = request_timeout
          faraday.options.open_timeout = open_timeout
          faraday.headers["Authorization"] = "Bearer #{api_key}"
        end
      end

      def build_generation_payload(prompt)
        payload = {
          model: model,
          prompt: combine_prompt(prompt)
        }

        optional = config.slice(:response_format, :size, :quality, :background, :style, :n, :user)
        payload.merge!(optional.compact)
        payload
      end

      def build_edit_payload(prompt, reference_images)
        payload = {
          "model" => model,
          "prompt" => combine_prompt(prompt),
          "image" => reference_images.map { |image| build_upload_io(image) }
        }

        optional = config.slice(:response_format, :mask, :size, :quality, :background, :style, :n, :user)
        optional.each do |key, value|
          payload[key] = value if value.present?
        end

        payload
      end

      def build_images(payload)
        Array(payload["data"]).filter_map do |item|
          uri = item["url"]
          base64 = item["b64_json"]
          mime = item["mime_type"] || "image/png"

          inline_data = base64.present? ? { data: base64, mime_type: mime } : nil

          Image.new(uri: uri, inline_data: inline_data)
        end
      end

      def build_upload_io(image)
        data = if image.respond_to?(:data)
                 image.data
               else
                 image.dig(:inlineData, :data)
               end

        mime = if image.respond_to?(:mime_type)
                 image.mime_type
               else
                 image.dig(:inlineData, :mimeType) || image.dig(:inlineData, :mime_type)
               end

        filename = if image.respond_to?(:filename)
                     image.filename
                   else
                     image[:filename]
                   end

        raise Error, "Reference image is missing data" if data.blank?

        decoded = Base64.decode64(data)
        Faraday::UploadIO.new(StringIO.new(decoded), mime || "application/octet-stream", filename || default_filename(mime))
      end

      def mime_extension(mime_type)
        case mime_type
        when "image/png" then ".png"
        when "image/jpeg" then ".jpg"
        when "image/gif" then ".gif"
        when "image/webp" then ".webp"
        else ""
        end
      end

      def default_filename(mime_type)
        "reference-#{SecureRandom.hex(4)}#{mime_extension(mime_type)}"
      end

      def combine_prompt(prompt)
        [prompt.system_prompt, prompt.text].filter_map { |part| part.presence }.join("\n\n")
      end

      def parse_response(response)
        payload = response.body.present? ? JSON.parse(response.body) : {}
        return payload if response.success?

        Rails.logger.error do
          {
            event: "image_generation.openai.http_error",
            status: response.status,
            response_body: payload
          }
        end

        message = payload.dig("error", "message") || "HTTP #{response.status}"
        raise Error, "OpenAI request failed: #{message}"
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

      def request_timeout
        config.fetch(:request_timeout, 30)
      end

      def open_timeout
        config.fetch(:open_timeout, 10)
      end
    end

    OpenAI = OpenAi
  end
end
