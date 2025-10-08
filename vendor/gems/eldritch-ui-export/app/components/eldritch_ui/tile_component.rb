# frozen_string_literal: true

class EldritchUi::TileComponent < ViewComponent::Base
  def initialize(
    selection_mode: :none,
    selected: false,
    value: "",
    name: nil,
    size: :medium,
    disabled: false,
    href: nil,
    turbo_method: nil,
    turbo_frame: nil,
    aria_label: nil,
    **html_attributes
  )
    @selection_mode = selection_mode.to_sym
    @selected = selected
    @value = value
    @name = name
    @size = size.to_sym
    @disabled = disabled
    @href = href
    @turbo_method = turbo_method
    @turbo_frame = turbo_frame
    @aria_label = aria_label
    @html_attributes = html_attributes
  end

  renders_one :icon
  renders_one :subtitle

  private

  attr_reader :selection_mode, :selected, :value, :name, :size, :disabled, :href,
              :turbo_method, :turbo_frame, :aria_label, :html_attributes

  def wrapper_attributes
    # Create a copy to avoid modifying the original
    attrs = html_attributes.dup

    # Extract and handle special attributes
    custom_class = attrs.delete(:class)

    # Merge component classes with any custom classes
    combined_classes = [ wrapper_css_classes, custom_class ].compact.join(" ")

    base_attrs = {
      class: combined_classes,
      data: stimulus_data.merge(attrs.fetch(:data, {})),
      **attrs.except(:data)
    }

    # Add accessibility attributes
    base_attrs[:role] = "button"
    base_attrs[:tabindex] = disabled ? "-1" : "0"
    base_attrs[:"aria-label"] = aria_label if aria_label.present?

    # Add selection-specific attributes
    if selection_mode != :none
      base_attrs[:"aria-pressed"] = selected.to_s
    end

    # Add disabled state
    if disabled
      base_attrs[:"aria-disabled"] = "true"
    end

    # Add navigation attributes
    if href.present? && selection_mode == :none
      base_attrs[:"data-href"] = href
      base_attrs[:"data-turbo-method"] = turbo_method if turbo_method.present?
      base_attrs[:"data-turbo-frame"] = turbo_frame if turbo_frame.present?
    end

    base_attrs
  end

  def wrapper_css_classes
    classes = [ "eld-tile" ]
    classes << "eld-tile--#{size}" if size != :medium
    classes << "eld-tile--selected" if selected
    classes << "eld-tile--disabled" if disabled
    classes << "eld-tile--#{selection_mode}" unless selection_mode == :none
    classes.compact.join(" ")
  end

  def stimulus_data
    {
      controller: "eldritch-ui--tile",
      "eldritch-ui--tile-selection-mode-value": selection_mode.to_s,
      "eldritch-ui--tile-selected-value": selected,
      "eldritch-ui--tile-value-value": value,
      "eldritch-ui--tile-name-value": name || "",
      "eldritch-ui--tile-disabled-value": disabled,
      action: "click->eldritch-ui--tile#click keydown->eldritch-ui--tile#keydown"
    }
  end

  def hidden_input_name
    return nil unless name.present? && selection_mode != :none
    name
  end

  def hidden_input_value
    return nil unless name.present? && selection_mode != :none
    selected ? value : ""
  end

  def has_icon?
    icon.present?
  end

  def has_subtitle?
    subtitle.present?
  end

  def tile_content_attributes
    {
      class: "eld-tile__content"
    }
  end

  def icon_container_attributes
    {
      class: "eld-tile__icon"
    }
  end

  def text_attributes
    {
      class: "eld-tile__text"
    }
  end

  def subtitle_attributes
    {
      class: "eld-tile__subtitle"
    }
  end
end
