class EldritchUi::LoadingOverlayComponentPreview < ViewComponent::Preview
  # @label Default (Hidden)
  def default
    render EldritchUi::LoadingOverlayComponent.new
  end

  # @label Visible
  def visible
    render EldritchUi::LoadingOverlayComponent.new(visible: true)
  end

  # @label With Message
  def with_message
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: "Loading your data..."
    )
  end

  # @label Long Message
  def long_message
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: "Please wait while we process your request. This may take a few moments as we gather all the necessary information and prepare your personalized results."
    )
  end

  # @label Container Overlay
  def container_overlay
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      full_screen: false,
      message: "Loading content..."
    )
  end

  # @label Full Screen Overlay
  def full_screen_overlay
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      full_screen: true,
      message: "Processing assignment..."
    )
  end

  # @label Without Message
  def without_message
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: nil
    )
  end

  # @label Data Processing
  def data_processing
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: "Analyzing your answers and calculating results..."
    )
  end

  # @label File Upload
  def file_upload
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: "Uploading your assignment files..."
    )
  end

  # @label Saving Progress
  def saving_progress
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: "Saving your progress..."
    )
  end

  # @label Generation Process
  def generation_process
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: "Generating your personalized learning materials..."
    )
  end

  # @label Quick Loading
  def quick_loading
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: "Just a moment..."
    )
  end

  # @label Custom Classes
  def custom_classes
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: "Loading with custom styling...",
      class: "custom-overlay-class"
    )
  end

  # @label Accessibility Demo
  def accessibility_demo
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: "This overlay is accessible to screen readers and keyboard users",
      role: "dialog",
      "aria-label": "Loading dialog"
    )
  end

  # @label Interactive Demo
  def interactive_demo
    render EldritchUi::LoadingOverlayComponent.new(
      visible: false,
      message: "Click the button below to show this overlay",
      "data-testid": "interactive-overlay"
    )
  end

  # @label Error Handling
  def error_state
    render EldritchUi::LoadingOverlayComponent.new(
      visible: true,
      message: "If this takes too long, please refresh the page..."
    )
  end
end 