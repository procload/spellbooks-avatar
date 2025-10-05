# frozen_string_literal: true

class ImageGenerationJob < ApplicationJob
  queue_as :default

  def perform(template:, attributes:, reference_image_signed_ids: [], provider: nil)
    ImageGeneration::Client.new.generate(
      template: template,
      attributes: attributes,
      reference_image_signed_ids: reference_image_signed_ids,
      provider: provider
    )
  end
end
