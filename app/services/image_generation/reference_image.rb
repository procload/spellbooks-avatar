# frozen_string_literal: true

module ImageGeneration
  ReferenceImage = Struct.new(
    :data,
    :mime_type,
    :filename,
    :origin,
    keyword_init: true
  )
end
