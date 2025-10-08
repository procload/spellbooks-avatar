# frozen_string_literal: true

require "test_helper"

module ImageGeneration
  class ReferenceImageBuilderTest < ActiveSupport::TestCase
    test "build returns array of inline data for valid image blobs" do
      mock_blob = Minitest::Mock.new
      mock_blob.expect :blank?, false
      mock_blob.expect :image?, true
      mock_blob.expect :content_type, "image/png"
      mock_blob.expect :download, "binary_image_data"
      mock_blob.expect :filename, "reference.png"

      resolver = ->(signed_id) { mock_blob }
      builder = ReferenceImageBuilder.new(resolver: resolver)

      result = builder.build([ "signed_id_1" ])

      assert_equal 1, result.length
      assert_equal "image/png", result.first.mime_type
      assert_equal Base64.strict_encode64("binary_image_data"), result.first.data
      assert_equal "reference.png", result.first.filename
      mock_blob.verify
    end

    test "build filters out nil blobs" do
      resolver = ->(signed_id) { nil }
      builder = ReferenceImageBuilder.new(resolver: resolver)

      result = builder.build([ "invalid_signed_id" ])

      assert_empty result
    end

    test "build raises error for non-image blobs" do
      mock_blob = Minitest::Mock.new
      mock_blob.expect :blank?, false
      mock_blob.expect :image?, false
      mock_blob.expect :id, 123

      resolver = ->(signed_id) { mock_blob }
      builder = ReferenceImageBuilder.new(resolver: resolver)

      error = assert_raises(ReferenceImageBuilder::InvalidReferenceImage) do
        builder.build([ "signed_id_1" ])
      end

      assert_equal "Blob 123 is not an image", error.message
      mock_blob.verify
    end

    test "build handles multiple signed ids" do
      mock_blob1 = Minitest::Mock.new
      mock_blob1.expect :blank?, false
      mock_blob1.expect :image?, true
      mock_blob1.expect :content_type, "image/png"
      mock_blob1.expect :download, "data1"
      mock_blob1.expect :filename, "one.png"

      mock_blob2 = Minitest::Mock.new
      mock_blob2.expect :blank?, false
      mock_blob2.expect :image?, true
      mock_blob2.expect :content_type, "image/jpeg"
      mock_blob2.expect :download, "data2"
      mock_blob2.expect :filename, "two.jpg"

      blobs = { "id1" => mock_blob1, "id2" => mock_blob2 }
      resolver = ->(signed_id) { blobs[signed_id] }
      builder = ReferenceImageBuilder.new(resolver: resolver)

      result = builder.build([ "id1", "id2" ])

      assert_equal 2, result.length
      assert_equal "image/png", result[0].mime_type
      assert_equal "image/jpeg", result[1].mime_type
      mock_blob1.verify
      mock_blob2.verify
    end

    test "default resolver handles invalid signed ids gracefully" do
      builder = ReferenceImageBuilder.new

      result = builder.build([ "invalid_signed_id" ])

      assert_empty result
    end

    test "build accepts nil and returns empty array" do
      builder = ReferenceImageBuilder.new(resolver: ->(_) { nil })

      result = builder.build(nil)

      assert_empty result
    end
  end
end
