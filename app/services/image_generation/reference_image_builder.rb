# frozen_string_literal: true

require "base64"

module ImageGeneration
  class ReferenceImageBuilder
    class InvalidReferenceImage < StandardError; end

    def initialize(resolver: method(:find_blob))
      @resolver = resolver
    end

    def build(signed_ids)
      Array(signed_ids).filter_map do |signed_id|
        blob = resolver.call(signed_id)
        next if blob.blank?
        validate!(blob)
        ImageGeneration::ReferenceImage.new(
          data: Base64.strict_encode64(blob.download),
          mime_type: blob.content_type,
          filename: blob.filename&.to_s,
          origin: :active_storage
        )
      end
    end

    def build_from_paths(file_paths)
      Array(file_paths).filter_map do |path|
        next unless File.exist?(path)

        content = File.binread(path)
        mime_type = detect_mime_type(path)

        ImageGeneration::ReferenceImage.new(
          data: Base64.strict_encode64(content),
          mime_type: mime_type,
          filename: File.basename(path),
          origin: :filesystem
        )
      end
    end

    private

    attr_reader :resolver

    def find_blob(signed_id)
      ActiveStorage::Blob.find_signed(signed_id)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      nil
    end

    def validate!(blob)
      return if blob.image?

      raise InvalidReferenceImage, "Blob #{blob.id} is not an image"
    end

    def detect_mime_type(path)
      case File.extname(path).downcase
      when ".png" then "image/png"
      when ".jpg", ".jpeg" then "image/jpeg"
      when ".gif" then "image/gif"
      when ".webp" then "image/webp"
      else "application/octet-stream"
      end
    end
  end
end
