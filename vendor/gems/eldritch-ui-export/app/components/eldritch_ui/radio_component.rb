# frozen_string_literal: true

class EldritchUi::RadioComponent < ViewComponent::Base
  def initialize(label: nil, name: nil, value: nil, checked: false, disabled: false, **html_attributes)
    @label = label
    @name = name
    @value = value
    @checked = checked
    @disabled = disabled
    @html_attributes = html_attributes
  end

  private

  attr_reader :label, :name, :value, :checked, :disabled, :html_attributes

  def wrapper_attributes
    # Create a copy to avoid modifying the original
    attrs = html_attributes.dup

    # Extract and handle special attributes
    custom_class = attrs.delete(:class)

    # Merge component classes with any custom classes
    combined_classes = [ wrapper_css_classes, custom_class ].compact.join(" ")

    {
      class: combined_classes,
      **attrs.except(:id, :data)
    }
  end

  def input_attributes
    base_attributes = {
      type: "radio",
      class: "eld-radio__input",
      name: name.to_s,
      value: value.to_s,
      checked: checked ? true : nil,
      disabled: disabled,
      id: input_id
    }

    # Handle data attributes properly
    data_attrs = html_attributes[:data]
    if data_attrs.is_a?(Hash)
      data_attrs.each do |key, val|
        base_attributes[:"data-#{key}"] = val.to_s
      end
    end

    base_attributes.compact
  end

  def label_attributes
    {
      class: "eld-radio__label",
      for: input_id
    }
  end

  def input_id
    html_attributes[:id] || "radio_#{name}_#{value}".gsub(/[^a-zA-Z0-9_-]/, "_")
  end

  def wrapper_css_classes
    classes = [ "eld-radio" ]
    classes << "eld-radio--checked" if checked
    classes << "eld-radio--disabled" if disabled
    classes.compact.join(" ")
  end
end
