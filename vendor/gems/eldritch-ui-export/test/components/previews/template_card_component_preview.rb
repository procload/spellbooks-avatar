# frozen_string_literal: true

# Lookbook previews for EldritchUi::TemplateCardComponent
class EldritchUi::TemplateCardComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param title "Template title"
  # @param subject select "Subject" :subject_options
  # @param grade select "Grade (number or label)" :grade_options
  # @param questions number "Questions"
  # @param difficulty select "Difficulty" :difficulty_options
  def playground(title: "Reading Comprehension", subject: "English", grade: "4", questions: 8, difficulty: "Medium")
    render EldritchUi::TemplateCardComponent.new(
      title: title,
      subject: subject,
      grade: grade,
      questions: questions,
      difficulty: difficulty,
      interests: ["Space", "Animals"]
    )
  end

  # @!group Subjects
  def math
    render EldritchUi::TemplateCardComponent.new(title: "Fractions Practice", subject: "Math", grade: 5, questions: 10)
  end

  def science
    render EldritchUi::TemplateCardComponent.new(title: "Solar System", subject: "Science", grade: 6, questions: 12)
  end

  def english
    render EldritchUi::TemplateCardComponent.new(title: "Poetry Analysis", subject: "English", grade: 8, questions: 6)
  end

  def history
    render EldritchUi::TemplateCardComponent.new(title: "Civil War Overview", subject: "History", grade: 11, questions: 8)
  end

  def art
    render EldritchUi::TemplateCardComponent.new(title: "Color Theory", subject: "Art", grade: 7, questions: 5)
  end

  # @!group With Interests
  def with_interests
    render EldritchUi::TemplateCardComponent.new(
      title: "Custom Quiz",
      subject: "Science",
      grade: 4,
      questions: 10,
      difficulty: "Hard",
      interests: ["Dinosaurs", "Volcanoes", "Space", "Robots"]
    )
  end

  private

  def subject_options
    %w[Math Science English History Art]
  end

  def grade_options
    %w[0 1 2 3 4 5 6 7 8 9 10 11 12 Kindergarten]
  end

  def difficulty_options
    %w[Easy Medium Hard]
  end
end

