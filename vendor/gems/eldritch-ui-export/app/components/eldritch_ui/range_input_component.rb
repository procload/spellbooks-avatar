# frozen_string_literal: true

module EldritchUi
  class RangeInputComponent < ViewComponent::Base
    def initialize(
      name:,
      value: nil,
      min: 0,
      max: 100,
      step: 1,
      show_value: true,
      required: false,
      disabled: false,
      **html_attributes
    )
      @name = name
      @value = value
      @min = min
      @max = max
      @step = step
      @show_value = show_value
      @required = required
      @disabled = disabled
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :name, :value, :min, :max, :step, :show_value, :required, :disabled

    def input_id
      @input_id ||= html_attributes[:id] || "range_input_#{name}_#{SecureRandom.hex(4)}"
    end

    def input_name
      @input_name ||= html_attributes[:name] || name
    end

    def wrapper_attributes
      {
        "data-controller": "eldritch-ui--range-input",
        "data-eldritch-ui--range-input-show-value-value": show_value
      }
    end

    def input_attributes
      base_attrs = {
        type: "range",
        id: input_id,
        name: input_name,
        value: value,
        min: min,
        max: max,
        step: step,
        required: required,
        disabled: disabled,
        "data-eldritch-ui--range-input-target": "input",
        "data-action": "input->eldritch-ui--range-input#updateValue"
      }

      # Merge with additional HTML attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split

      attrs.merge!(base_attrs)
      attrs[:class] = (default_css_classes.split + custom_classes).uniq.join(" ")

      attrs.compact
    end

    def default_css_classes
      classes = [ "eld-range-input" ]
      classes << "eld-range-input--disabled" if disabled
      classes.join(" ")
    end

    def html_attributes
      @html_attributes
    end

    def current_value
      value || min
    end
  end
end
