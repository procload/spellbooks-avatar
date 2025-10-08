# frozen_string_literal: true

class EldritchUi::TagComponent < EldritchUi::PillComponent
  VALID_VARIANTS = [ :default, :primary, :secondary, :dark, :outline, :success, :warning, :error ].freeze

  def initialize(text: nil, dismissible: false, variant: :default, value: nil, href: nil, **html_attributes)
    @dismissible = dismissible
    @variant = validate_variant(variant)
    super(text: text, interactive: false, selected: false, value: value, href: href, **html_attributes)
  end

  private

  attr_reader :dismissible, :variant

  def element_attributes
    attributes = super

    # Add Stimulus controller for dismissible tags
    if dismissible
      # Simple approach: just set the data-controller attribute directly
      existing_controller = attributes[:"data-controller"]
      new_controller = existing_controller.present? ?
        "#{existing_controller} eldritch-ui--tag" :
        "eldritch-ui--tag"
      attributes[:"data-controller"] = new_controller.to_s
    end

    attributes
  end

  def css_classes
    classes = [ "eld-tag" ]
    classes << "eld-tag--dismissible" if dismissible
    classes << "eld-tag--#{variant}" if variant != :default
    classes.compact.join(" ")
  end

  def validate_variant(variant_input)
    variant_sym = variant_input.to_sym
    unless VALID_VARIANTS.include?(variant_sym)
      raise ArgumentError, "Invalid variant: #{variant_input}. Must be one of: #{VALID_VARIANTS.join(', ')}"
    end
    variant_sym
  end
end
