# frozen_string_literal: true

class EldritchUi::SegmentedControlComponentPreview < ViewComponent::Preview
  # 🎮 Segmented Control playground! 🎮
  # -----------------------------------
  # You can use the controls in the 'Params' section
  # to set segmented control property values on the fly.
  #
  # @param value "Currently selected value"
  # @param name "Name for form submission"
  # @param size select "Size of the control" :size_options
  # @param full_width [Boolean] toggle "Should the control take full width?"
  # @param disabled [Boolean] toggle "Is the control disabled?"
  # @param aria_label "ARIA label for accessibility"
  def playground(
    value: "medium",
    name: "difficulty",
    size: :medium,
    full_width: false,
    disabled: false,
    aria_label: "Difficulty selection"
  )
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "easy", label: "Easy" },
        { value: "medium", label: "Medium" },
        { value: "hard", label: "Hard" }
      ],
      value: value,
      name: name.present? ? name : nil,
      size: size,
      full_width: full_width,
      disabled: disabled,
      aria_label: aria_label.present? ? aria_label : nil
    )
  end

  # Attached field with label
  # @!group Attached Field Examples
  def with_attached_label
    render EldritchUi::SegmentedControlComponent.new(
      label: "Difficulty Level",
      options: [
        { value: "easy", label: "Easy" },
        { value: "medium", label: "Medium" },
        { value: "hard", label: "Hard" }
      ],
      value: "medium",
      name: "difficulty"
    )
  end

  # Attached field with description
  # @!group Attached Field Examples
  def with_description
    render EldritchUi::SegmentedControlComponent.new(
      label: "Grade Level",
      description: "Select the appropriate grade level for this assignment",
      options: [
        { value: "k", label: "K" },
        { value: "1", label: "1st" },
        { value: "2", label: "2nd" },
        { value: "3", label: "3rd" },
        { value: "4", label: "4th" },
        { value: "5", label: "5th" }
      ],
      value: "3",
      name: "grade_level"
    )
  end

  # Attached field with error
  # @!group Attached Field Examples
  def with_error
    render EldritchUi::SegmentedControlComponent.new(
      label: "Subject",
      error_message: "Please select a subject for this assignment",
      options: [
        { value: "math", label: "Math" },
        { value: "science", label: "Science" },
        { value: "english", label: "English" },
        { value: "history", label: "History" }
      ],
      name: "subject"
    )
  end

  # Standalone mode (no attached styling)
  # @!group Attached Field Examples
  def standalone_mode
    render EldritchUi::SegmentedControlComponent.new(
      label: "View Mode",
      standalone: true,
      options: [
        { value: "list", label: "List" },
        { value: "grid", label: "Grid" },
        { value: "card", label: "Card" }
      ],
      value: "grid",
      name: "view_mode"
    )
  end

  # Default segmented control
  # @!group Basic Examples
  def default
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "easy", label: "Easy" },
        { value: "medium", label: "Medium" },
        { value: "hard", label: "Hard" }
      ],
      value: "easy",
      aria_label: "Difficulty selection"
    )
  end

  # Many options example
  # @!group Basic Examples
  def many_options
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "k", label: "K" },
        { value: "1", label: "1st" },
        { value: "2", label: "2nd" },
        { value: "3", label: "3rd" },
        { value: "4", label: "4th" },
        { value: "5", label: "5th" }
      ],
      value: "3",
      aria_label: "Grade level selection"
    )
  end

  # With disabled options
  # @!group Selection Examples
  def with_disabled_options
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "basic", label: "Basic" },
        { value: "premium", label: "Premium", disabled: true },
        { value: "enterprise", label: "Enterprise", disabled: true }
      ],
      value: "basic",
      aria_label: "Feature availability"
    )
  end

  # Form integration example
  # @!group Form Examples
  def form_integration
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "monthly", label: "Monthly" },
        { value: "yearly", label: "Yearly" }
      ],
      value: "yearly",
      name: "subscription_plan",
      aria_label: "Subscription plan"
    )
  end

  # Small size variant
  # @!group Size Examples
  def small_size
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "list", label: "List" },
        { value: "grid", label: "Grid" },
        { value: "card", label: "Card" }
      ],
      value: "grid",
      size: :small,
      aria_label: "View mode"
    )
  end

  # Large size variant
  # @!group Size Examples
  def large_size
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "monthly", label: "Monthly" },
        { value: "yearly", label: "Yearly" }
      ],
      value: "yearly",
      size: :large,
      aria_label: "Subscription plan"
    )
  end

  # Full width variant
  # @!group Layout Examples
  def full_width
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "assignments", label: "Assignments" },
        { value: "quizzes", label: "Quizzes" },
        { value: "lessons", label: "Lessons" }
      ],
      value: "assignments",
      full_width: true,
      aria_label: "Content type"
    )
  end

  # Disabled state
  # @!group State Examples
  def disabled_state
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "easy", label: "Easy" },
        { value: "medium", label: "Medium" },
        { value: "hard", label: "Hard" }
      ],
      value: "medium",
      disabled: true,
      aria_label: "Difficulty selection"
    )
  end

  # Two options (binary choice)
  # @!group Advanced Examples
  def binary_choice
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "public", label: "Public" },
        { value: "private", label: "Private" }
      ],
      value: "private",
      aria_label: "Visibility setting"
    )
  end

  # Subject selection
  # @!group Advanced Examples
  def subject_selection
    render EldritchUi::SegmentedControlComponent.new(
      options: [
        { value: "math", label: "Math" },
        { value: "science", label: "Science" },
        { value: "english", label: "English" },
        { value: "history", label: "History" }
      ],
      value: "math",
      name: "subject",
      aria_label: "Subject selection"
    )
  end

  private

  def size_options
    [:small, :medium, :large]
  end
end 