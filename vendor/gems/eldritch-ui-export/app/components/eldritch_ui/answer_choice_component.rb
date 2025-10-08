module EldritchUi
  class AnswerChoiceComponent < ViewComponent::Base
    def initialize(letter:, text:, name:, value:, selected: false, disabled: false, correct: nil, incorrect: nil, explanation: nil, **html_attributes)
      @letter = letter.to_s.upcase
      @text = text
      @name = name
      @value = value
      @selected = selected
      @disabled = disabled
      @correct = correct
      @incorrect = incorrect
      @explanation = explanation
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :letter, :text, :name, :value, :selected, :disabled, :correct, :incorrect, :explanation

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?

      # Add Stimulus controller and data attributes
      attrs["data-controller"] = "eldritch-ui--answer-choice"
      attrs["data-eldritch-ui--answer-choice-selected-value"] = selected
      attrs["data-eldritch-ui--answer-choice-disabled-value"] = disabled
      attrs["data-action"] = "click->eldritch-ui--answer-choice#select"

      attrs
    end

    def default_css_classes
      classes = [ "eld-answer-choice" ]
      classes << "eld-answer-choice--selected" if selected?
      classes << "eld-answer-choice--disabled" if disabled?
      classes << "eld-answer-choice--correct" if correct?
      classes << "eld-answer-choice--incorrect" if incorrect?
      classes.join(" ")
    end

    def radio_button_attributes
      {
        class: "eld-answer-choice__input",
        disabled: disabled,
        "data-eldritch-ui--answer-choice-target": "input"
      }
    end

    def letter_badge_classes
      classes = [ "eld-answer-choice__letter" ]
      classes << "eld-answer-choice__letter--selected" if selected?
      classes << "eld-answer-choice__letter--correct" if correct?
      classes << "eld-answer-choice__letter--incorrect" if incorrect?
      classes.join(" ")
    end

    def checkmark_classes
      classes = [ "eld-answer-choice__checkmark" ]
      classes << "eld-answer-choice__checkmark--visible" if selected? || correct? || incorrect?
      classes.join(" ")
    end

    def feedback_icon_name
      return "check" if correct?
      return "x" if incorrect?
      "check" # default for selected state
    end

    def feedback_icon_classes
      classes = [ "eld-answer-choice__checkmark-icon" ]
      classes << "eld-answer-choice__checkmark-icon--correct" if correct?
      classes << "eld-answer-choice__checkmark-icon--incorrect" if incorrect?
      classes.join(" ")
    end

    def explanation_classes
      classes = [ "eld-answer-choice__explanation" ]
      classes << "eld-answer-choice__explanation--visible" if show_explanation?
      classes.join(" ")
    end

    def show_explanation?
      correct? && explanation.present?
    end

    def selected?
      @selected
    end

    def disabled?
      @disabled
    end

    def correct?
      @correct == true
    end

    def incorrect?
      @incorrect == true
    end

    def radio_button_id
      @radio_button_id ||= "#{name}_#{value}".parameterize
    end
  end
end
