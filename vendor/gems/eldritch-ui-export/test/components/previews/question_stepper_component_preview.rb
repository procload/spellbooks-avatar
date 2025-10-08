# frozen_string_literal: true

# Lookbook previews for EldritchUi::QuestionStepperComponent
class EldritchUi::QuestionStepperComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param value number "Current value"
  # @param min number "Minimum"
  # @param max number "Maximum (optional)"
  # @param step number "Step"
  # @param required [Boolean] toggle "Required?"
  # @param disabled [Boolean] toggle "Disabled?"
  def playground(value: 6, min: 1, max: 12, step: 1, required: false, disabled: false)
    render EldritchUi::QuestionStepperComponent.new(
      name: "questions",
      value: value,
      min: min,
      max: max,
      step: step,
      required: required,
      disabled: disabled
    )
  end

  # @!group Basic
  def default
    render EldritchUi::QuestionStepperComponent.new(name: "questions")
  end

  def with_limits
    render EldritchUi::QuestionStepperComponent.new(name: "questions", min: 3, max: 15, value: 10)
  end

  def disabled
    render EldritchUi::QuestionStepperComponent.new(name: "questions", disabled: true, value: 8)
  end

  def required
    render EldritchUi::QuestionStepperComponent.new(name: "questions", required: true)
  end
end

