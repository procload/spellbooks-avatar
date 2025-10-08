# frozen_string_literal: true

# Lookbook previews for EldritchUi::GradeLevelSelectorComponent
class EldritchUi::GradeLevelSelectorComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param value select "Selected grade (string)" :values
  # @param required [Boolean] toggle "Required?"
  # @param disabled [Boolean] toggle "Disabled?"
  def playground(value: "3", required: false, disabled: false)
    render EldritchUi::GradeLevelSelectorComponent.new(
      name: "grade",
      value: value,
      required: required,
      disabled: disabled
    )
  end

  # @!group Basic
  def default
    render EldritchUi::GradeLevelSelectorComponent.new(name: "grade")
  end

  def selected_grade
    render EldritchUi::GradeLevelSelectorComponent.new(name: "grade", value: "9")
  end

  def disabled
    render EldritchUi::GradeLevelSelectorComponent.new(name: "grade", disabled: true)
  end

  def required
    render EldritchUi::GradeLevelSelectorComponent.new(name: "grade", required: true)
  end

  private

  def values
    %w[0 1 2 3 4 5 6 7 8 9 10 11 12]
  end
end

