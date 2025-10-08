# frozen_string_literal: true

class ImageGenerationJob < ApplicationJob
  queue_as :default

  BACKOFF = ->(executions) { 5 * (2**(executions - 1)) }

  retry_on Faraday::TimeoutError, wait: BACKOFF, attempts: 3
  retry_on Faraday::ConnectionFailed, wait: BACKOFF, attempts: 3
  discard_on ImageGeneration::ProviderError
  discard_on ImageGeneration::PromptLoader::MissingTemplateError
  discard_on ImageGeneration::ReferenceImageBuilder::InvalidReferenceImage

  def perform(avatar_id:)
    avatar = Avatar.find(avatar_id)
    avatar.update!(status: :processing)

    # Build reference image paths from local assets
    reference_paths = build_reference_paths(limit: 3)

    response = ImageGeneration::Client.new.generate(
      template: "avatar",
      attributes: avatar.attributes.slice("name", "gender", "klass", "traits").symbolize_keys,
      reference_image_paths: reference_paths
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
  rescue Faraday::TimeoutError, Faraday::ConnectionFailed => e
    Rails.logger.error "Image generation network error for avatar #{avatar_id}: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    raise
  rescue StandardError => e
    Rails.logger.error "Image generation failed for avatar #{avatar_id}: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")

    avatar = Avatar.find_by(id: avatar_id)
    avatar&.update(
      status: :failed,
      error_message: e.message
    )
    raise unless e.is_a?(ImageGeneration::ProviderError)
  end

  private

  def build_reference_paths(limit: nil)
    reference_dir = Rails.root.join("app", "assets", "images", "reference")
    return [] unless Dir.exist?(reference_dir)

    files = Dir.glob(reference_dir.join("*.{png,jpg,jpeg,gif,webp}"))
               .sort
               .select { |path| File.exist?(path) }

    limit ? files.first(limit) : files
  end
end
