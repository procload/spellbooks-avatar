# frozen_string_literal: true

class EldritchUi::SegmentedControlComponent < ViewComponent::Base
  def initialize(
    options: [],
    value: nil,
    name: nil,
    label: nil,
    description: nil,
    error_message: nil,
    size: :medium,
    full_width: false,
    disabled: false,
    standalone: false,
    aria_label: nil,
    aria_labelledby: nil,
    **html_attributes
  )
    @options = options
    @value = value
    @name = name
    @label = label
    @description = description
    @error_message = error_message
    @size = size.to_sym
    @full_width = full_width
    @disabled = disabled
    @standalone = standalone
    @aria_label = aria_label
    @aria_labelledby = aria_labelledby
    @html_attributes = html_attributes
  end

  private

  attr_reader :options, :value, :name, :label, :description, :error_message,
              :size, :full_width, :disabled, :standalone,
              :aria_label, :aria_labelledby, :html_attributes

  def wrapper_attributes
    # Create a copy to avoid modifying the original
    attrs = html_attributes.dup

    # Extract and handle special attributes
    custom_class = attrs.delete(:class)

    # Merge component classes with any custom classes
    combined_classes = [ wrapper_css_classes, custom_class ].compact.join(" ")

    base_attrs = {
      class: combined_classes,
      **attrs
    }

    base_attrs
  end

  def wrapper_css_classes
    classes = []

    if has_label?
      classes << "eld-attached-field"
      classes << "eld-attached-field--standalone" if standalone
      classes << "eld-attached-field--disabled" if disabled
      classes << "eld-attached-field--error" if has_error?
    else
      classes << "eld-segmented-control"
      classes << "eld-segmented-control--disabled" if disabled
    end

    classes << "eld-segmented-control--#{size}" if size != :medium
    classes << "eld-segmented-control--full-width" if full_width
    classes.compact.join(" ")
  end

  def label_css_classes
    classes = [ "eld-attached-field__label" ]
    classes << "eld-attached-field__label--required" if required?
    classes.join(" ")
  end

  def control_wrapper_css_classes
    classes = [ "eld-attached-field__wrapper" ]
    classes.join(" ")
  end

  def segmented_control_css_classes
    classes = [ "eld-segmented-control" ]
    classes << "eld-segmented-control--#{size}" if size != :medium
    classes << "eld-segmented-control--full-width" if full_width
    classes << "eld-segmented-control--disabled" if disabled
    classes.compact.join(" ")
  end

  def stimulus_data
    {
      "data-controller": "eldritch-ui--segmented-control",
      "data-eldritch-ui--segmented-control-value-value": value || "",
      "data-eldritch-ui--segmented-control-name-value": name || "",
      "data-eldritch-ui--segmented-control-disabled-value": disabled
    }
  end

  def container_attributes
    attrs = {
      class: "eld-segmented-control__container",
      role: "radiogroup"
    }

    attrs[:"aria-label"] = aria_label if aria_label.present?
    attrs[:"aria-labelledby"] = aria_labelledby if aria_labelledby.present?
    attrs[:"aria-disabled"] = "true" if disabled

    # Merge stimulus data attributes
    attrs.merge!(stimulus_data)

    attrs
  end

  def segment_attributes(option)
    option_value = option.is_a?(Hash) ? option[:value] || option["value"] : option.to_s
    option_label = option.is_a?(Hash) ? option[:label] || option["label"] : option.to_s
    option_disabled = option.is_a?(Hash) ? !!(option[:disabled] || option["disabled"]) : false

    is_selected = option_value == value
    is_disabled = disabled || option_disabled

    {
      class: "eld-segmented-control__segment",
      role: "radio",
      "data-value": option_value,
      "aria-checked": is_selected.to_s,
      "aria-disabled": is_disabled.to_s,
      tabindex: (is_selected && !is_disabled) ? "0" : "-1"
    }
  end

  def segment_label_attributes
    {
      class: "eld-segmented-control__label"
    }
  end

  def option_value(option)
    option.is_a?(Hash) ? option[:value] || option["value"] : option.to_s
  end

  def option_label(option)
    option.is_a?(Hash) ? option[:label] || option["label"] : option.to_s
  end

  def option_disabled?(option)
    return false unless option.is_a?(Hash)
    option[:disabled] || option["disabled"]
  end

  def hidden_input_name
    return nil unless name.present?
    name
  end

  def hidden_input_value
    return nil unless name.present?
    value || ""
  end

  def has_hidden_input?
    name.present?
  end

  # Template helper methods
  def css_classes
    wrapper_css_classes
  end

  def processed_options
    Array(options).map do |option|
      if option.is_a?(Hash)
        option_value = option[:value] || option["value"] || option.to_s
        option_label = option[:label] || option["label"] || option.to_s
        option_disabled = !!(option[:disabled] || option["disabled"])
      else
        option_value = option.to_s
        option_label = option.to_s
        option_disabled = false
      end

      {
        value: option_value,
        label: option_label,
        disabled: option_disabled,
        selected: option_value == value
      }
    end
  end

  def has_label?
    label.present?
  end

  def has_description?
    description.present?
  end

  def has_error?
    error_message.present?
  end

  def required?
    # For now, we don't have a required parameter, but this maintains consistency
    false
  end

  def field_id
    @field_id ||= name.present? ? name.to_s.gsub(/\W/, "_") : "segmented_control_#{object_id}"
  end

  def description_id
    "#{field_id}_description" if has_description?
  end

  def error_id
    "#{field_id}_error" if has_error?
  end

  def aria_describedby
    ids = []
    ids << description_id if has_description?
    ids << error_id if has_error?
    ids.any? ? ids.join(" ") : nil
  end
end
