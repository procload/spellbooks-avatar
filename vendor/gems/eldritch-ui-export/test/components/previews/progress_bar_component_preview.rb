# frozen_string_literal: true

# Lookbook previews for EldritchUi::ProgressBarComponent
class EldritchUi::ProgressBarComponentPreview < ViewComponent::Preview
  # 🎉 Progress Bar playground! 🎉
  # -----------------------
  # You can use the controls in the 'Params' section
  # to set progress bar property values on the fly.
  #
  # @param value "Current progress value"
  # @param max "Maximum value (default: 100)"
  # @param label "Optional label for accessibility"
  # @param size select "Size of the progress bar" :size_options
  def playground(value: 50, max: 100, label: "", size: :medium)
    render EldritchUi::ProgressBarComponent.new(
      value: value,
      max: max,
      label: label.present? ? label : nil,
      size: size
    )
  end

  # Default progress bar
  # @!group Basic Examples
  def default
    render EldritchUi::ProgressBarComponent.new(value: 50)
  end

  # Progress bar with different values
  # @!group Progress States
  def empty
    render EldritchUi::ProgressBarComponent.new(value: 0)
  end

  def quarter_complete
    render EldritchUi::ProgressBarComponent.new(value: 25)
  end

  def half_complete
    render EldritchUi::ProgressBarComponent.new(value: 50)
  end

  def three_quarters_complete
    render EldritchUi::ProgressBarComponent.new(value: 75)
  end

  def complete
    render EldritchUi::ProgressBarComponent.new(value: 100)
  end

  # Progress bars with custom max values
  # @!group Custom Max Values
  def custom_max_low_progress
    render EldritchUi::ProgressBarComponent.new(value: 3, max: 10)
  end

  def custom_max_high_progress
    render EldritchUi::ProgressBarComponent.new(value: 8, max: 10)
  end

  def custom_max_complete
    render EldritchUi::ProgressBarComponent.new(value: 10, max: 10)
  end

  # Size variants
  # @!group Sizes
  def small
    render EldritchUi::ProgressBarComponent.new(
      value: 60,
      size: :small
    )
  end

  def medium
    render EldritchUi::ProgressBarComponent.new(
      value: 60,
      size: :medium
    )
  end

  def large
    render EldritchUi::ProgressBarComponent.new(
      value: 60,
      size: :large
    )
  end

  # With accessibility labels
  # @!group Accessibility
  def with_label
    render EldritchUi::ProgressBarComponent.new(
      value: 65,
      label: "Assignment completion progress"
    )
  end

  def upload_progress
    render EldritchUi::ProgressBarComponent.new(
      value: 85,
      label: "File upload progress"
    )
  end

  def loading_progress
    render EldritchUi::ProgressBarComponent.new(
      value: 42,
      label: "Page loading progress"
    )
  end

  # Edge cases
  # @!group Edge Cases
  def over_max_value
    render EldritchUi::ProgressBarComponent.new(value: 150, max: 100)
  end

  def negative_value
    render EldritchUi::ProgressBarComponent.new(value: -25, max: 100)
  end

  def decimal_values
    render EldritchUi::ProgressBarComponent.new(value: 33.33, max: 100)
  end

  def zero_max
    render EldritchUi::ProgressBarComponent.new(value: 50, max: 0)
  end

  # Real-world examples
  # @!group Real-world Examples
  def assignment_progress
    render EldritchUi::ProgressBarComponent.new(
      value: 7,
      max: 10,
      label: "Math homework progress (7/10 problems completed)"
    )
  end

  def quiz_progress
    render EldritchUi::ProgressBarComponent.new(
      value: 15,
      max: 20,
      label: "Quiz progress (15/20 questions answered)"
    )
  end

  def reading_progress
    render EldritchUi::ProgressBarComponent.new(
      value: 245,
      max: 350,
      label: "Reading progress (245/350 pages read)"
    )
  end

  # Custom styling example
  # @!group Custom Styling
  def with_custom_class
    render EldritchUi::ProgressBarComponent.new(
      value: 70,
      class: "mb-4",
      id: "custom-progress"
    )
  end

  private

  def size_options
    [:small, :medium, :large]
  end
end 