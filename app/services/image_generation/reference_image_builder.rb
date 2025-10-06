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
        {
          inlineData: {
            mimeType: blob.content_type,
            data: Base64.strict_encode64(blob.download)
          }
        }
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
  end
end
