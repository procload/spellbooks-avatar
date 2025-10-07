# frozen_string_literal: true

class ImageGenerationJob < ApplicationJob
  queue_as :default

  retry_on Faraday::TimeoutError, wait: :exponentially_longer, attempts: 3
  retry_on Faraday::ConnectionFailed, wait: :exponentially_longer, attempts: 3
  discard_on ImageGeneration::Providers::Gemini::Error
  discard_on ImageGeneration::PromptLoader::MissingTemplateError
  discard_on ImageGeneration::ReferenceImageBuilder::InvalidReferenceImage

  def perform(avatar_id:)
    avatar = Avatar.find(avatar_id)
    avatar.update!(status: :processing)

    response = ImageGeneration::Client.new.generate(
      template: "avatar",
      attributes: avatar.attributes.slice("name", "gender", "klass", "traits").symbolize_keys
    )

    if response.images.any? && response.images.first.inline_data
      image = response.images.first
      avatar.update!(
        status: :completed,
        image_data: image.inline_data[:data],
        image_mime_type: image.inline_data[:mime_type]
      )
    else
      avatar.update!(
        status: :failed,
        error_message: "No images returned from API"
      )
    end
  rescue StandardError => e
    Rails.logger.error "Image generation failed for avatar #{avatar_id}: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")

    avatar = Avatar.find_by(id: avatar_id)
    avatar&.update(
      status: :failed,
      error_message: e.message
    )
    raise unless e.is_a?(ImageGeneration::Providers::Gemini::Error)
  end
end
