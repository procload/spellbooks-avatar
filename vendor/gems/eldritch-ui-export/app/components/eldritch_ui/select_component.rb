# frozen_string_literal: true

class EldritchUi::SelectComponent < ViewComponent::Base
  attr_reader :options, :value, :name, :size, :multiple, :disabled,
              :required, :placeholder, :aria_label, :label, :description,
              :error_message, :standalone, :html_attributes

  def initialize(
    options: [],
    value: nil,
    name: nil,
    size: :default,
    multiple: false,
    disabled: false,
    required: false,
    placeholder: nil,
    label: nil,
    description: nil,
    error_message: nil,
    standalone: false,
    aria_label: nil,
    css_class: nil,
    **html_attributes
  )
    @options = options
    @value = value
    @name = name
    @size = size.to_sym
    @multiple = multiple
    @disabled = disabled
    @required = required
    @placeholder = placeholder
    @label = label
    @description = description
    @error_message = error_message
    @standalone = standalone
    @aria_label = aria_label
    @html_attributes = html_attributes

    # Handle CSS classes for the container
    @html_attributes[:class] = class_names(
      "eld-attached-field",
      "eld-select",
      "eld-attached-field--#{@size}" => @size != :default,
      "eld-attached-field--standalone" => @standalone,
      "eld-attached-field--disabled" => @disabled,
      "eld-attached-field--error" => @error_message.present?,
      "eld-attached-field--required" => @required,
      css_class => css_class.present?
    )
  end

  private

  def select_id
    @select_id ||= html_attributes[:id] || "select_#{name}_#{SecureRandom.hex(4)}"
  end

  def label_id
    "#{select_id}_label" if label.present?
  end

  def description_id
    "#{select_id}_description" if description.present?
  end

  def error_id
    "#{select_id}_error" if error_message.present?
  end

  def select_attributes
    attrs = {
      id: select_id,
      name: name,
      class: select_field_css_classes,
      multiple: multiple,
      disabled: disabled,
      required: required
    }

    attrs[:"aria-label"] = aria_label if aria_label.present?
    attrs[:"aria-labelledby"] = label_id if label_id
    attrs[:"aria-describedby"] = [ description_id, error_id ].compact.join(" ") if description_id || error_id
    attrs[:"aria-invalid"] = "true" if error_message.present?

    attrs.merge(html_attributes.except(:class, :id))
  end

  def select_field_css_classes
    classes = [ "eld-select__field" ]
    classes << "eld-select__field--#{size}" if size != :default
    classes << "eld-select__field--multiple" if multiple
    classes.join(" ")
  end

  def label_attributes
    {
      id: label_id,
      for: select_id,
      class: "eld-attached-field__label"
    }
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
        selected: option_selected?(option_value)
      }
    end
  end

  def option_selected?(option_value)
    return false unless value.present?

    if multiple
      # For multiple selection, value can be an array or comma-separated string
      values = value.is_a?(Array) ? value : value.to_s.split(",").map(&:strip)
      values.include?(option_value)
    else
      value.to_s == option_value
    end
  end

  def show_placeholder?
    placeholder.present? && !multiple
  end
end
