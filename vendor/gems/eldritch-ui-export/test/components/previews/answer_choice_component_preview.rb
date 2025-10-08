class EldritchUi::AnswerChoiceComponentPreview < ViewComponent::Preview
  # @label Default
  def default
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "A",
      text: "This is the first answer choice for the question.",
      name: "question_1",
      value: "choice_a"
    )
  end

  # @label Selected State
  def selected
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "B",
      text: "This answer choice is currently selected.",
      name: "question_1",
      value: "choice_b",
      selected: true
    )
  end

  # @label Disabled State
  def disabled
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "C",
      text: "This answer choice is disabled and cannot be selected.",
      name: "question_1",
      value: "choice_c",
      disabled: true
    )
  end

  # @label Selected and Disabled
  def selected_disabled
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "D",
      text: "This answer was previously selected but is now disabled.",
      name: "question_1",
      value: "choice_d",
      selected: true,
      disabled: true
    )
  end

  # @label Correct Answer with Explanation
  def correct_answer_with_explanation
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "A",
      text: "This is the correct answer - shows green styling with checkmark and explanation.",
      name: "question_feedback",
      value: "correct_choice",
      selected: true,
      disabled: true,
      correct: true,
      explanation: "This explanation appears below the correct answer to help students understand why this choice is right. It provides educational context and reinforces learning."
    )
  end

  # @label Correct Answer without Explanation
  def correct_answer
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "A",
      text: "This is the correct answer - shows green styling with checkmark but no explanation.",
      name: "question_feedback",
      value: "correct_choice",
      selected: true,
      disabled: true,
      correct: true
    )
  end

  # @label Incorrect Answer
  def incorrect_answer
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "B",
      text: "This is an incorrect answer - shows red styling with X mark.",
      name: "question_feedback",
      value: "incorrect_choice",
      selected: true,
      disabled: true,
      incorrect: true
    )
  end

  # @label Question with Feedback and Explanation
  def question_with_feedback_and_explanation
    content_tag :div, class: "space-y-3" do
      [
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "A",
          text: "The correct answer that the student selected - with explanation below.",
          name: "feedback_question",
          value: "choice_a",
          selected: true,
          disabled: true,
          correct: true,
          explanation: "This is the correct answer because it demonstrates the proper application of the scientific principle being tested. The explanation helps students understand the underlying concept."
        )),
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "B",
          text: "An unselected answer choice that was not correct.",
          name: "feedback_question",
          value: "choice_b",
          disabled: true
        )),
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "C",
          text: "Another unselected answer choice.",
          name: "feedback_question",
          value: "choice_c",
          disabled: true
        )),
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "D",
          text: "Yet another unselected answer choice.",
          name: "feedback_question",
          value: "choice_d",
          disabled: true
        ))
      ].join.html_safe
    end
  end

  # @label Question with Feedback
  def question_with_feedback
    content_tag :div, class: "space-y-3" do
      [
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "A",
          text: "The correct answer that the student selected.",
          name: "feedback_question_2",
          value: "choice_a",
          selected: true,
          disabled: true,
          correct: true
        )),
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "B",
          text: "An unselected answer choice.",
          name: "feedback_question_2",
          value: "choice_b",
          disabled: true
        )),
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "C",
          text: "Another unselected answer choice.",
          name: "feedback_question_2",
          value: "choice_c",
          disabled: true
        )),
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "D",
          text: "Yet another unselected answer choice.",
          name: "feedback_question_2",
          value: "choice_d",
          disabled: true
        ))
      ].join.html_safe
    end
  end

  # @label Question with Wrong Answer
  def question_with_wrong_answer
    content_tag :div, class: "space-y-3" do
      [
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "A",
          text: "The correct answer that shows as correct even though not selected.",
          name: "wrong_question",
          value: "choice_a",
          disabled: true,
          correct: true
        )),
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "B",
          text: "The incorrect answer that the student selected.",
          name: "wrong_question",
          value: "choice_b",
          selected: true,
          disabled: true,
          incorrect: true
        )),
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "C",
          text: "An unselected answer choice.",
          name: "wrong_question",
          value: "choice_c",
          disabled: true
        )),
        render(EldritchUi::AnswerChoiceComponent.new(
          letter: "D",
          text: "Another unselected answer choice.",
          name: "wrong_question",
          value: "choice_d",
          disabled: true
        ))
      ].join.html_safe
    end
  end

  # @label Letter A
  def letter_a
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "A",
      text: "First option using letter A",
      name: "question_letters",
      value: "choice_a"
    )
  end

  # @label Letter B
  def letter_b
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "B",
      text: "Second option using letter B",
      name: "question_letters",
      value: "choice_b"
    )
  end

  # @label Number 1
  def number_1
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "1",
      text: "First option using number 1",
      name: "question_numbers",
      value: "choice_1"
    )
  end

  # @label Number 2  
  def number_2
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "2",
      text: "Second option using number 2",
      name: "question_numbers",
      value: "choice_2"
    )
  end

  # @label Long Text Content
  def long_text
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "A",
      text: "This is a very long answer choice that demonstrates how the component handles text that wraps to multiple lines. The layout should remain consistent and readable even with extensive content that exceeds the typical single-line length.",
      name: "question_long",
      value: "choice_long"
    )
  end

  # @label Math Question Choice
  def math_question
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "A",
      text: "42 (The answer to life, the universe, and everything)",
      name: "math_question",
      value: "answer_42"
    )
  end

  # @label History Question Choice
  def history_question
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "B",
      text: "1776 (The year the Declaration of Independence was signed)",
      name: "history_question", 
      value: "answer_1776"
    )
  end

  # @label Science Question Choice
  def science_question
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "C",
      text: "The speed of light in a vacuum is approximately 299,792,458 meters per second",
      name: "science_question",
      value: "speed_of_light"
    )
  end

  # @label Custom Styling
  def custom_styling
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "A",
      text: "Answer choice with custom CSS classes.",
      name: "question_custom",
      value: "choice_custom",
      class: "shadow-lg border-2"
    )
  end

  # @label Empty Text
  def empty_text
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "A",
      text: "",
      name: "edge_case_question",
      value: "empty_text"
    )
  end

  # @label Special Characters
  def special_characters
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "α",
      text: "Option with Greek letter and special chars: !@#$%^&*()",
      name: "special_question",
      value: "special_chars"
    )
  end

  # @label With Focus Ring
  def with_focus
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "A",
      text: "Tab to this answer choice to see focus styles",
      name: "focus_question",
      value: "focus_demo",
      "data-testid": "focus-demo"
    )
  end

  # @label Hover State Demo
  def hover_demo
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "B",
      text: "Hover over this answer choice to see hover styles",
      name: "hover_question", 
      value: "hover_demo"
    )
  end

  # @label Form Field Integration
  def form_field
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "A",
      text: "Answer choice integrated with Rails form helpers",
      name: "quiz[question_1]",
      value: "option_a"
    )
  end

  # @label Active State Demo
  def active_demo
    render EldritchUi::AnswerChoiceComponent.new(
      letter: "C",
      text: "Click this answer to see active/selection behavior",
      name: "interactive_question",
      value: "interactive_choice"
    )
  end
end 