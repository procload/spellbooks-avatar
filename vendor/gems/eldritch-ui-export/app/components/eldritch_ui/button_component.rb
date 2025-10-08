# frozen_string_literal: true

class EldritchUi::ButtonComponent < ViewComponent::Base
  def initialize(label: nil, variant: :primary, size: :medium, href: nil, type: "button", disabled: false, toggle: false, pressed: nil, **html_attributes)
    @label = label
    @variant = variant.to_sym
    @size = size.to_sym
    @href = href
    @type = type
    @disabled = disabled
    @toggle = toggle
    @pressed = pressed
    @html_attributes = html_attributes
  end

  private

  attr_reader :label, :variant, :size, :href, :type, :disabled, :toggle, :pressed, :html_attributes

  def element_tag
    href.present? ? :a : :button
  end

  def element_attributes
    # Merge component classes with any custom classes from html_attributes
    combined_classes = [ css_classes, html_attributes.delete(:class) ].compact.join(" ")

    base_attributes = {
      class: combined_classes,
      **html_attributes
    }

    # Add toggle-specific attributes
    if toggle
      base_attributes[:"data-action"] = "click->eldritch-ui--button#toggle"
    end

    # Add aria-pressed for toggle buttons when pressed state is explicitly set
    if !pressed.nil?
      base_attributes[:"aria-pressed"] = pressed.to_s
    end

    if element_tag == :a
      base_attributes[:href] = href unless disabled
      base_attributes[:role] = "button"
      base_attributes[:"aria-disabled"] = "true" if disabled
      base_attributes[:tabindex] = "-1" if disabled
    else
      base_attributes[:type] = type
      base_attributes[:disabled] = disabled if disabled
    end

    base_attributes
  end

  def css_classes
    classes = [ "eld-btn" ]
    classes << "eld-btn--#{variant}" if variant != :primary
    classes << "eld-btn--#{size}" # Always add size class
    classes << "eld-btn--disabled" if disabled
    classes << "eld-btn--pressed" if pressed
    classes.compact.join(" ")
  end
end
