# frozen_string_literal: true

module EldritchUi
  class NumberInputComponent < ViewComponent::Base
    def initialize(
      name:,
      value: nil,
      min: nil,
      max: nil,
      step: nil,
      placeholder: nil,
      required: false,
      disabled: false,
      readonly: false,
      **html_attributes
    )
      @name = name
      @value = value
      @min = min
      @max = max
      @step = step
      @placeholder = placeholder
      @required = required
      @disabled = disabled
      @readonly = readonly
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :name, :value, :min, :max, :step, :placeholder, :required, :disabled, :readonly

    def input_id
      @input_id ||= html_attributes[:id] || "number_input_#{name}_#{SecureRandom.hex(4)}"
    end

    def input_name
      @input_name ||= html_attributes[:name] || name
    end

    def input_attributes
      base_attrs = {
        type: "number",
        id: input_id,
        name: input_name,
        value: value,
        placeholder: placeholder,
        required: required,
        disabled: disabled,
        readonly: readonly
      }

      # Add numeric constraints if provided
      base_attrs[:min] = min if min.present?
      base_attrs[:max] = max if max.present?
      base_attrs[:step] = step if step.present?

      # Merge with additional HTML attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split

      attrs.merge!(base_attrs)
      attrs[:class] = (default_css_classes.split + custom_classes).uniq.join(" ")

      attrs.compact
    end

    def default_css_classes
      classes = [ "eld-number-input" ]
      classes << "eld-number-input--disabled" if disabled
      classes << "eld-number-input--readonly" if readonly
      classes.join(" ")
    end

    def html_attributes
      @html_attributes
    end
  end
end
