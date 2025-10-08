# frozen_string_literal: true

class EldritchUi::RadioGroupComponent < ViewComponent::Base
  def initialize(legend: nil, name: nil, value: nil, options: [], **html_attributes)
    @legend = legend
    @name = name
    @value = value
    @options = options
    @html_attributes = html_attributes
  end

  private

  attr_reader :legend, :name, :value, :options, :html_attributes

  def fieldset_attributes
    # Create a copy to avoid modifying the original
    attrs = html_attributes.dup

    # Extract and handle special attributes
    custom_class = attrs.delete(:class)

    # Merge component classes with any custom classes
    combined_classes = [ css_classes, custom_class ].compact.join(" ")

    {
      class: "#{combined_classes} eld-radio-group__fieldset".strip,
      role: "radiogroup",
      **attrs
    }
  end

  def legend_attributes
    {
      class: legend_css_classes
    }
  end

  def legend_css_classes
    classes = [ "eld-radio-group__legend" ]
    classes << "eld-radio-group__legend--hidden" if legend.blank?
    classes.compact.join(" ")
  end

  def css_classes
    [ "eld-radio-group" ].compact.join(" ")
  end

  def radio_options
    # If options are provided, generate radio buttons from them
    # Otherwise, expect radio buttons to be provided as content
    return [] if options.blank?

    options.map do |option|
      case option
      when Hash
        {
          label: option[:label] || option["label"],
          value: option[:value] || option["value"],
          checked: (option[:value] || option["value"]) == value,
          disabled: option[:disabled] || option["disabled"] || false
        }
      when Array
        {
          label: option[0],
          value: option[1] || option[0],
          checked: (option[1] || option[0]) == value,
          disabled: false
        }
      else
        {
          label: option.to_s,
          value: option.to_s,
          checked: option.to_s == value.to_s,
          disabled: false
        }
      end
    end
  end
end
