# frozen_string_literal: true

# Lookbook previews for EldritchUi::GradeLevelPillsComponent
class EldritchUi::GradeLevelPillsComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param value select "Selected value" :value_options
  # @param required [Boolean] toggle "Required?"
  def playground(value: "K-2", required: false)
    render EldritchUi::GradeLevelPillsComponent.new(
      name: "grade_level",
      id: "grade-level-pills",
      value: value,
      required: required
    )
  end

  # @!group Basic
  def default
    render EldritchUi::GradeLevelPillsComponent.new(
      name: "grade_level",
      id: "grade-level-pills"
    )
  end

  def preselected_group
    render EldritchUi::GradeLevelPillsComponent.new(
      name: "grade_level",
      id: "grade-level-pills",
      value: "3-5"
    )
  end

  def preselected_individual
    render EldritchUi::GradeLevelPillsComponent.new(
      name: "grade_level",
      id: "grade-level-pills",
      value: "7th Grade"
    )
  end

  def required
    render EldritchUi::GradeLevelPillsComponent.new(
      name: "grade_level",
      id: "grade-level-pills",
      required: true
    )
  end

  private

  def value_options
    [
      "K-2", "3-5", "6-8", "9-12",
      "Kindergarten", "1st Grade", "2nd Grade", "3rd Grade", "4th Grade", "5th Grade",
      "6th Grade", "7th Grade", "8th Grade", "9th Grade", "10th Grade", "11th Grade", "12th Grade"
    ]
  end
end

