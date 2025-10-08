# frozen_string_literal: true

module EldritchUi
  class GradeLevelSelectorComponent < ViewComponent::Base
    def initialize(
      name:,
      id: nil,
      value: nil,
      label: "Grade Level",
      required: false,
      disabled: false,
      **html_attributes
    )
      @name = name
      @id = id || "grade-level-selector-#{SecureRandom.hex(4)}"
      @value = value
      @label = label
      @required = required
      @disabled = disabled
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :name, :id, :value, :label, :required, :disabled, :html_attributes

    def grade_groups
      [
        {
          label: "K-2",
          values: [ "0", "1", "2" ],
          grades: [ "Kindergarten", "1st Grade", "2nd Grade" ]
        },
        {
          label: "3-5",
          values: [ "3", "4", "5" ],
          grades: [ "3rd Grade", "4th Grade", "5th Grade" ]
        },
        {
          label: "6-8",
          values: [ "6", "7", "8" ],
          grades: [ "6th Grade", "7th Grade", "8th Grade" ]
        },
        {
          label: "9-12",
          values: [ "9", "10", "11", "12" ],
          grades: [ "9th Grade", "10th Grade", "11th Grade", "12th Grade" ]
        }
      ]
    end

    def all_individual_grades
      [
        { value: "0", label: "Kindergarten" },
        { value: "1", label: "1st Grade" },
        { value: "2", label: "2nd Grade" },
        { value: "3", label: "3rd Grade" },
        { value: "4", label: "4th Grade" },
        { value: "5", label: "5th Grade" },
        { value: "6", label: "6th Grade" },
        { value: "7", label: "7th Grade" },
        { value: "8", label: "8th Grade" },
        { value: "9", label: "9th Grade" },
        { value: "10", label: "10th Grade" },
        { value: "11", label: "11th Grade" },
        { value: "12", label: "12th Grade" }
      ]
    end

    def input_attributes
      base_attrs = {
        name: name,
        required: required,
        disabled: disabled
      }

      attrs = html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split

      attrs.merge!(base_attrs)
      attrs[:class] = (default_css_classes.split + custom_classes).uniq.join(" ")

      attrs.compact
    end

    def default_css_classes
      classes = [ "eld-grade-level-selector" ]
      classes << "eld-grade-level-selector--disabled" if disabled
      classes.join(" ")
    end

    def radio_id(grade_value)
      "#{id}-#{grade_value}"
    end

    def is_selected?(grade_value)
      value.to_s == grade_value.to_s
    end

    def get_group_for_value(grade_value)
      grade_groups.find { |group| group[:values].include?(grade_value.to_s) }
    end

    def is_group_selected?(group)
      group[:values].include?(value.to_s)
    end

    def show_expanded_view?
      # Show expanded view if a value is selected or if it's been expanded
      value.present?
    end
  end
end
