# frozen_string_literal: true

module EldritchUi
  class BannerComponent < ViewComponent::Base
    VALID_VARIANTS = %i[default success warning error dark].freeze
    VALID_SIZES = %i[small default large].freeze
    VALID_ALIGNMENTS = %i[left center right].freeze

    def initialize(
      message: nil,
      variant: :default,
      size: :default,
      alignment: :center,
      tag: :div,
      **html_attributes
    )
      @message = message
      @variant = validate_variant(variant)
      @size = validate_size(size)
      @alignment = validate_alignment(alignment)
      @tag = tag
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :message, :variant, :size, :alignment, :tag

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?
      attrs
    end

    def default_css_classes
      classes = [ "eld-banner-message" ]
      classes << "eld-banner-message--#{variant}" if variant != :default
      classes << "eld-banner-message--#{size}" if size != :default
      classes << "eld-banner-message--#{alignment}" if alignment != :center
      classes.join(" ")
    end

    def validate_variant(variant)
      return variant if VALID_VARIANTS.include?(variant)

      raise ArgumentError, "Invalid variant: #{variant.inspect}. Valid variants are: #{VALID_VARIANTS.join(', ')}"
    end

    def validate_size(size)
      return size if VALID_SIZES.include?(size)

      raise ArgumentError, "Invalid size: #{size.inspect}. Valid sizes are: #{VALID_SIZES.join(', ')}"
    end

    def validate_alignment(alignment)
      return alignment if VALID_ALIGNMENTS.include?(alignment)

      raise ArgumentError, "Invalid alignment: #{alignment.inspect}. Valid alignments are: #{VALID_ALIGNMENTS.join(', ')}"
    end
  end
end
