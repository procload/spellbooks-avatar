# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

class ImageGenerationJobTest < ActiveJob::TestCase
  test "delegates generation to client" do
    client = Struct.new(:received_args) do
      def generate(**kwargs)
        self.received_args = kwargs
      end
    end.new

    expected_args = {
      template: "avatar",
      attributes: { persona: "mage" },
      reference_image_signed_ids: %w[signed-id],
      provider: :gemini
    }

    ImageGeneration::Client.stub :new, client do
      ImageGenerationJob.perform_now(**expected_args)
    end

    assert_equal expected_args, client.received_args
  end
end
