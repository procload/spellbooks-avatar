class EldritchUi::AssignmentImageComponentPreview < ViewComponent::Preview
  # @!group Different Image States

  # Default successful state with image
  def default
    assignment = create_mock_assignment
    # Mock successful image state
    assignment.define_singleton_method(:image_status) { 'success' }
    assignment.define_singleton_method(:image_status_message) { nil }
    assignment.define_singleton_method(:image_attached?) { true }
    assignment.define_singleton_method(:cached_image_variant) { 'placeholder.png' }
    
    render EldritchUi::AssignmentImageComponent.new(assignment: assignment)
  end

  # Image generation in progress
  def generating_state
    assignment = create_mock_assignment
    assignment.define_singleton_method(:generation_phase) { 'image_generation' }
    assignment.define_singleton_method(:image_status) { 'generating' }
    assignment.define_singleton_method(:image_status_message) { 'Image is being generated...' }
    assignment.define_singleton_method(:image_attached?) { false }
    
    render EldritchUi::AssignmentImageComponent.new(assignment: assignment)
  end

  # Image generation failed with error
  def error_state
    assignment = create_mock_assignment
    assignment.define_singleton_method(:image_generation_error) { 'Image generation failed due to an unexpected error. Please try regenerating the image.' }
    assignment.define_singleton_method(:image_status) { 'error' }
    assignment.define_singleton_method(:image_status_message) { 'Image generation failed due to an unexpected error. Please try regenerating the image.' }
    assignment.define_singleton_method(:image_generation_failed?) { true }
    assignment.define_singleton_method(:image_attached?) { false }
    assignment.define_singleton_method(:can_regenerate_image?) { true }
    
    render EldritchUi::AssignmentImageComponent.new(
      assignment: assignment,
      show_regenerate_button: true
    )
  end

  # Timeout error specifically
  def timeout_error
    assignment = create_mock_assignment
    assignment.define_singleton_method(:image_generation_error) { 'Image generation took too long and timed out. Please try regenerating the image.' }
    assignment.define_singleton_method(:image_status) { 'error' }
    assignment.define_singleton_method(:image_status_message) { 'Image generation took too long and timed out. Please try regenerating the image.' }
    assignment.define_singleton_method(:image_generation_failed?) { true }
    assignment.define_singleton_method(:image_attached?) { false }
    assignment.define_singleton_method(:can_regenerate_image?) { true }
    
    render EldritchUi::AssignmentImageComponent.new(
      assignment: assignment,
      show_regenerate_button: true
    )
  end

  # Inappropriate content error
  def inappropriate_content_error
    assignment = create_mock_assignment
    assignment.define_singleton_method(:image_generation_error) { 'The content was flagged as inappropriate for image generation. Please try modifying the assignment topic.' }
    assignment.define_singleton_method(:image_status) { 'error' }
    assignment.define_singleton_method(:image_status_message) { 'The content was flagged as inappropriate for image generation. Please try modifying the assignment topic.' }
    assignment.define_singleton_method(:image_generation_failed?) { true }
    assignment.define_singleton_method(:image_attached?) { false }
    assignment.define_singleton_method(:can_regenerate_image?) { true }
    
    render EldritchUi::AssignmentImageComponent.new(
      assignment: assignment,
      show_regenerate_button: true
    )
  end

  # Image file unavailable/corrupted
  def unavailable_state
    assignment = create_mock_assignment
    assignment.define_singleton_method(:image_status) { 'unavailable' }
    assignment.define_singleton_method(:image_status_message) { 'Image is temporarily unavailable' }
    assignment.define_singleton_method(:image_attached?) { true }
    assignment.define_singleton_method(:cached_image_variant) { nil }
    assignment.define_singleton_method(:can_regenerate_image?) { true }
    
    render EldritchUi::AssignmentImageComponent.new(
      assignment: assignment,
      show_regenerate_button: true
    )
  end

  # No image available
  def no_image_state
    assignment = create_mock_assignment
    assignment.define_singleton_method(:image_status) { 'none' }
    assignment.define_singleton_method(:image_status_message) { 'No image available' }
    assignment.define_singleton_method(:image_attached?) { false }
    assignment.define_singleton_method(:image_generation_failed?) { false }
    assignment.define_singleton_method(:generation_phase) { 'completed' }
    
    render EldritchUi::AssignmentImageComponent.new(assignment: assignment)
  end

  # @!group Variations

  # With custom CSS classes
  def with_custom_classes
    assignment = create_mock_assignment
    assignment.define_singleton_method(:image_status) { 'generating' }
    assignment.define_singleton_method(:image_status_message) { 'Image is being generated...' }
    assignment.define_singleton_method(:generation_phase) { 'image_generation' }
    assignment.define_singleton_method(:image_attached?) { false }
    
    render EldritchUi::AssignmentImageComponent.new(
      assignment: assignment,
      class: "border-2 border-dashed border-blue-300 rounded-lg"
    )
  end

  # Error without regenerate button
  def error_without_regenerate
    assignment = create_mock_assignment
    assignment.define_singleton_method(:image_generation_error) { 'Image generation failed due to service being unavailable. Please try again later.' }
    assignment.define_singleton_method(:image_status) { 'error' }
    assignment.define_singleton_method(:image_status_message) { 'Image generation failed due to service being unavailable. Please try again later.' }
    assignment.define_singleton_method(:image_generation_failed?) { true }
    assignment.define_singleton_method(:image_attached?) { false }
    assignment.define_singleton_method(:can_regenerate_image?) { false }
    
    render EldritchUi::AssignmentImageComponent.new(
      assignment: assignment,
      show_regenerate_button: false
    )
  end

  # @!group Grid Layout

  # All states in a grid for comparison
  def all_states_grid
    states = [
      { name: 'Success', component: default },
      { name: 'Generating', component: generating_state },
      { name: 'Error', component: error_state },
      { name: 'Timeout Error', component: timeout_error },
      { name: 'Inappropriate Content', component: inappropriate_content_error },
      { name: 'Unavailable', component: unavailable_state },
      { name: 'No Image', component: no_image_state }
    ]

    content_tag :div, class: "grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 p-4" do
      states.map do |state|
        content_tag :div, class: "space-y-2" do
          content_tag(:h3, state[:name], class: "text-sm font-medium text-gray-700 text-center") +
          content_tag(:div, state[:component], class: "border border-gray-200 rounded-lg p-2")
        end
      end.join.html_safe
    end
  end

  private

  def create_mock_assignment
    assignment = OpenStruct.new(
      id: 1,
      title: "Space Technology Assignment",
      subject: "Science",
      grade_level: "5",
      difficulty: "Medium",
      number_of_questions: 5,
      interests: "satellites and space technology",
      status: 'completed',
      generation_phase: 'completed',
      image_generation_error: nil
    )
    
    # Add methods that will be called by the component
    assignment.define_singleton_method(:image_generation_failed?) { false }
    assignment.define_singleton_method(:can_regenerate_image?) { false }
    assignment.define_singleton_method(:image) { nil }
    
    assignment
  end
end 