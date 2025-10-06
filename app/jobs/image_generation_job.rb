# frozen_string_literal: true

class ImageGenerationJob < ApplicationJob
  queue_as :default

  retry_on Faraday::TimeoutError, wait: :exponentially_longer, attempts: 3
  retry_on Faraday::ConnectionFailed, wait: :exponentially_longer, attempts: 3
  discard_on ImageGeneration::Providers::Gemini::Error
  discard_on ImageGeneration::PromptLoader::MissingTemplateError
  discard_on ImageGeneration::ReferenceImageBuilder::InvalidReferenceImage

  def perform(template:, attributes:, reference_image_signed_ids: [], provider: nil)
    ImageGeneration::Client.new.generate(
      template: template,
      attributes: attributes,
      reference_image_signed_ids: reference_image_signed_ids,
      provider: provider
    )
  end
end
