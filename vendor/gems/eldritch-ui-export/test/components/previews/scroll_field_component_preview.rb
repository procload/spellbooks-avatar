# frozen_string_literal: true

class EldritchUi::ScrollFieldComponentPreview < ViewComponent::Preview
  # @!group Basic Variants
  def default
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "QUESTION TEXT",
      text: "What is the capital of France? This is a sample question that demonstrates how the parchment scroll field will look with typical content."
    )
  end

  def short_content
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "SHORT QUESTION",
      text: "Quick question?"
    )
  end

  def long_content
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "DETAILED QUESTION",
      text: "This is a much longer question that spans multiple lines to demonstrate how the parchment scroll handles extensive content. It should maintain its beautiful aged appearance while accommodating various content lengths. The scroll should feel natural and maintain its medieval aesthetic regardless of the amount of text within."
    )
  end

  # @!group Editable Variants
  def editable_empty
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "NEW QUESTION",
      name: "question_new",
      placeholder: "Enter your question here...",
      editable: true
    )
  end

  def single_line_input
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "QUESTION TITLE",
      name: "question_title",
      placeholder: "Enter a short title...",
      editable: true,
      single_line: true
    )
  end

  def single_line_with_value
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "EMAIL ADDRESS",
      name: "user_email",
      text: "user@example.com",
      type: :email,
      editable: true,
      single_line: true
    )
  end

  def editable_with_content
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "EDIT QUESTION",
      text: "What magical spell would you use to solve this problem?",
      name: "question_edit",
      editable: true
    )
  end

  def editable_large
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "ESSAY QUESTION",
      text: "Describe in detail your approach to this complex magical scenario...",
      name: "essay_question",
      rows: 10,
      editable: true
    )
  end

  # @!group Content Type Variants
  def answer_field
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "STUDENT ANSWER",
      text: "Paris is the capital of France. It is located in the northern part of the country and serves as the political, economic, and cultural center."
    )
  end

  def instruction_field
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "INSTRUCTIONS",
      text: "Read the following passage carefully and answer the questions that follow. Pay attention to key details and supporting evidence."
    )
  end

  def feedback_field
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "TEACHER FEEDBACK",
      text: "Excellent work! Your analysis shows deep understanding of the topic. Consider expanding on your third point for even stronger support of your argument."
    )
  end

  # @!group Label Variants
  def unix_manual_style
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "UNIX COMMAND",
      text: "grep -r 'pattern' /usr/local/bin/\n\nThis command searches recursively for a pattern in the specified directory. Use with caution on system directories."
    )
  end

  def code_example
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "CODE SNIPPET",
      text: "def magic_spell(ingredients)\n  ingredients.each do |ingredient|\n    puts \"Adding #{ingredient} to cauldron...\"\n  end\nend"
    )
  end

  def winky_sans_font_showcase
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "WINKY SANS FONT",
      text: "This label now uses the playful Winky Sans font at 600 weight and 18px size, perfect for educational content that's both fun and engaging. The font gives our labels a friendly, approachable appearance that fits the spellbooks theme. And this text content also uses Winky Sans for consistency!"
    )
  end

  def winky_rough_decorative
    render EldritchUi::ScrollFieldComponent.new(
      label_text: "DECORATIVE ROUGH FONT",
      text: "While the label uses clean Winky Sans, we also have Winky Rough available via --eldritch-font-family-decorative for special decorative elements. This creates a nice contrast between readable content and artistic flair."
    )
  end
end 