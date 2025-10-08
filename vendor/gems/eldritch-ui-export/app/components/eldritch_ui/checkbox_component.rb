# frozen_string_literal: true

module EldritchUi
  # Checkbox component for boolean input with proper accessibility and validation
  class CheckboxComponent < ViewComponent::Base
    attr_reader :name, :value, :checked, :disabled, :required, :label, :description, :error_message, :size, :variant, :html_attributes

    def initialize(
      name:,
      value: "1",
      checked: false,
      disabled: false,
      required: false,
      label: nil,
      description: nil,
      error_message: nil,
      size: :default,
      variant: :default,
      css_class: nil,
      **html_attributes
    )
      @name = name
      @value = value
      @checked = checked
      @disabled = disabled
      @required = required
      @label = label
      @description = description
      @error_message = error_message
      @size = size.to_sym
      @variant = variant.to_sym
      @html_attributes = html_attributes

      # Handle CSS classes
      @html_attributes[:class] = class_names(
        "eld-checkbox",
        "eld-checkbox--#{@size}" => @size != :default,
        "eld-checkbox--#{@variant}" => @variant != :default,
        "eld-checkbox--disabled" => @disabled,
        "eld-checkbox--error" => @error_message.present?,
        "eld-checkbox--required" => @required,
        css_class => css_class.present?
      )
    end

    private

    def checkbox_id
      @checkbox_id ||= html_attributes[:id] || "checkbox_#{name}_#{SecureRandom.hex(4)}"
    end

    def description_id
      "#{checkbox_id}_description" if description.present?
    end

    def error_id
      "#{checkbox_id}_error" if error_message.present?
    end

    def checkbox_attributes
      attrs = {
        id: checkbox_id,
        name: name,
        value: value,
        type: "checkbox",
        class: "eld-checkbox__input"
      }

      attrs[:checked] = true if checked
      attrs[:disabled] = true if disabled
      attrs[:required] = true if required
      attrs[:"aria-invalid"] = "true" if error_message.present?
      attrs[:"aria-describedby"] = [ description_id, error_id ].compact.join(" ") if description_id || error_id

      attrs.merge(html_attributes.except(:class, :id))
    end

    def label_attributes
      {
        for: checkbox_id,
        class: "eld-checkbox__label"
      }
    end
  end
end
