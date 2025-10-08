# frozen_string_literal: true

module EldritchUi
  # Text input component with validation, accessibility, and design system integration
  class TextInputComponent < ViewComponent::Base
    attr_reader :name, :value, :type, :placeholder, :disabled, :readonly, :required, :label, :description, :error_message, :size, :variant, :standalone, :html_attributes

    def initialize(
      name:,
      value: nil,
      type: :text,
      placeholder: nil,
      disabled: false,
      readonly: false,
      required: false,
      label: nil,
      description: nil,
      error_message: nil,
      size: :default,
      variant: :default,
      standalone: false,
      css_class: nil,
      **html_attributes
    )
      @name = name
      @value = value
      @type = type.to_s
      @placeholder = placeholder
      @disabled = disabled
      @readonly = readonly
      @required = required
      @label = label
      @description = description
      @error_message = error_message
      @size = size.to_sym
      @variant = variant.to_sym
      @standalone = standalone
      @html_attributes = html_attributes

      # Handle CSS classes
      @html_attributes[:class] = class_names(
        "eld-attached-field",
        "eld-text-input",
        "eld-attached-field--#{@size}" => @size != :default,
        "eld-attached-field--#{@variant}" => @variant != :default,
        "eld-attached-field--standalone" => @standalone,
        "eld-attached-field--disabled" => @disabled,
        "eld-attached-field--readonly" => @readonly,
        "eld-attached-field--error" => @error_message.present?,
        "eld-attached-field--required" => @required,
        css_class => css_class.present?
      )
    end

    private

    def input_id
      @input_id ||= html_attributes[:id] || "text_input_#{name}_#{SecureRandom.hex(4)}"
    end

    def label_id
      "#{input_id}_label" if label.present?
    end

    def description_id
      "#{input_id}_description" if description.present?
    end

    def error_id
      "#{input_id}_error" if error_message.present?
    end

    def input_attributes
      attrs = {
        id: input_id,
        name: name,
        type: type,
        class: input_field_css_classes
      }

      attrs[:value] = value if value.present?
      attrs[:placeholder] = placeholder if placeholder.present?
      attrs[:disabled] = true if disabled
      attrs[:readonly] = true if readonly
      attrs[:required] = true if required
      attrs[:"aria-invalid"] = "true" if error_message.present?
      attrs[:"aria-labelledby"] = label_id if label_id
      attrs[:"aria-describedby"] = [ description_id, error_id ].compact.join(" ") if description_id || error_id

      attrs.merge(html_attributes.except(:class, :id))
    end

    def input_field_css_classes
      classes = [ "eld-text-input__field" ]
      classes << "eld-text-input__field--#{size}" if size != :default
      classes.join(" ")
    end

    def label_attributes
      {
        id: label_id,
        for: input_id,
        class: "eld-attached-field__label"
      }
    end

    def valid_input_types
      %w[text email password url tel search number]
    end

    def type
      valid_input_types.include?(@type) ? @type : "text"
    end
  end
end
