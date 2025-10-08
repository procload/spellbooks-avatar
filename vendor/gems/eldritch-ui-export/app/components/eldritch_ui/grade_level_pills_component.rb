# frozen_string_literal: true

class EldritchUi::GradeLevelPillsComponent < ViewComponent::Base
  def initialize(name:, id:, value: nil, required: false, data: {}, **html_attributes)
    @name = name
    @id = id
    @value = value
    @required = required
    @data = data.stringify_keys
    @html_attributes = html_attributes
  end

  private

  attr_reader :name, :id, :value, :required, :data, :html_attributes

  def container_attributes
    {
      id: "#{id}_container",
      class: "eld-grade-level-pills",
      "data-controller": "grade-level-pills",
      "data-grade-level-pills-name-value": name,
      **data.transform_keys { |key| "data-#{key.tr('_', '-')}" }
    }
  end

  def grade_groups
    [
      { value: "K-2", label: "K-2", grades: ["Kindergarten", "1st Grade", "2nd Grade"] },
      { value: "3-5", label: "3-5", grades: ["3rd Grade", "4th Grade", "5th Grade"] },
      { value: "6-8", label: "6-8", grades: ["6th Grade", "7th Grade", "8th Grade"] },
      { value: "9-12", label: "9-12", grades: ["9th Grade", "10th Grade", "11th Grade", "12th Grade"] }
    ]
  end

  def individual_grades
    [
      "Kindergarten", "1st Grade", "2nd Grade", "3rd Grade", "4th Grade", "5th Grade",
      "6th Grade", "7th Grade", "8th Grade", "9th Grade", "10th Grade", "11th Grade", "12th Grade"
    ]
  end

  def selected?(grade_value)
    value == grade_value
  end
end