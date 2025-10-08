# frozen_string_literal: true

module EldritchUi
  class QuestionStepperComponent < ViewComponent::Base
    def initialize(
      name:,
      id: nil,
      value: nil,
      label: "Number of Questions",
      min: 1,
      max: nil,
      step: 1,
      required: false,
      disabled: false,
      hint: nil,
      **html_attributes
    )
      @name = name
      @id = id || "question-stepper-#{SecureRandom.hex(4)}"
      @value = value&.to_i || min
      @label = label
      @min = min.to_i
      @max = max&.to_i
      @step = step.to_i
      @required = required
      @disabled = disabled
      @hint = hint
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :name, :id, :value, :label, :min, :max, :step, :required, :disabled, :hint, :html_attributes

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
      classes = [ "eld-question-stepper" ]
      classes << "eld-question-stepper--disabled" if disabled
      classes.join(" ")
    end

    def number_input_id
      "#{id}-input"
    end

    def decrease_button_id
      "#{id}-decrease"
    end

    def increase_button_id
      "#{id}-increase"
    end

    def can_decrease?
      !disabled && value > min
    end

    def can_increase?
      !disabled && (max.nil? || value < max)
    end

    def default_hint
      if hint.present?
        hint
      else
        "Most teachers pick 6-10"
      end
    end

    def suggestions_for_grade_difficulty(grade, difficulty)
      # This will be called via JavaScript to get dynamic suggestions
      base_suggestion = case grade&.to_i
      when 0..2  # K-2
        case difficulty&.downcase
        when "easy" then 4
        when "hard" then 8
        else 6  # medium
        end
      when 3..5  # 3-5
        case difficulty&.downcase
        when "easy" then 6
        when "hard" then 10
        else 8  # medium
        end
      when 6..8  # 6-8
        case difficulty&.downcase
        when "easy" then 8
        when "hard" then 12
        else 10  # medium
        end
      when 9..12  # 9-12
        case difficulty&.downcase
        when "easy" then 10
        when "hard" then 15
        else 12  # medium
        end
      else
        8  # default
      end

      base_suggestion
    end
  end
end
