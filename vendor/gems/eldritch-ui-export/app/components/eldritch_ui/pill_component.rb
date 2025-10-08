# frozen_string_literal: true

class EldritchUi::PillComponent < ViewComponent::Base
  def initialize(text: nil, interactive: false, selected: false, value: nil, href: nil, size: :default, **html_attributes)
    @text = text
    @interactive = interactive
    @selected = selected
    @value = value
    @href = href
    @size = size.to_sym
    @html_attributes = html_attributes
  end

  private

  attr_reader :text, :interactive, :selected, :value, :href, :size, :html_attributes

  def element_tag
    href.present? ? :a : :div
  end

  def element_attributes
    # Start with base attributes
    attrs = {}

    # Merge custom classes with component classes
    custom_classes = html_attributes[:class].to_s.split
    default_classes = css_classes.split
    final_classes = (default_classes + custom_classes).uniq.join(" ")
    attrs[:class] = final_classes if final_classes.present?

    # Add conditional attributes
    attrs[:role] = "button" if interactive && element_tag == :div
    attrs[:tabindex] = "0" if interactive && element_tag == :div
    attrs[:"aria-pressed"] = selected.to_s if interactive
    attrs[:"data-value"] = value.to_s if value.present?

    # Add href for links
    if element_tag == :a
      attrs[:href] = href.to_s if href.present?
      attrs[:role] = "button" if interactive
    end

    # Process html_attributes
    html_attributes.each do |key, value|
      next if key == :class  # Skip class, we handle it above

      if key == :data && value.is_a?(Hash)
        # Handle data hash by flattening it
        value.each do |data_key, data_value|
          # Convert underscores to hyphens for data attributes
          hyphenated_key = data_key.to_s.tr("_", "-")
          attrs[:"data-#{hyphenated_key}"] = data_value.to_s
        end
      else
        attrs[key] = value.to_s
      end
    end

    attrs
  end

  def css_classes
    classes = [ "eld-pill" ]
    classes << "eld-pill--#{size}" if size != :default
    classes << "eld-pill--interactive" if interactive
    classes << "eld-pill--selected" if selected
    classes.compact.join(" ")
  end
end
