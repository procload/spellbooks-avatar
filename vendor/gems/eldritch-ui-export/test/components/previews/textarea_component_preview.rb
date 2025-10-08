# frozen_string_literal: true

# Lookbook previews for EldritchUi::TextareaComponent
class EldritchUi::TextareaComponentPreview < ViewComponent::Preview
  # 🎉 Textarea playground! 🎉
  # -----------------------
  # You can use the controls in the 'Params' section
  # to set textarea property values on the fly.
  #
  # @param label "Label text for the textarea"
  # @param placeholder "Placeholder text"
  # @param value "Current value of the textarea"
  # @param rows "Number of rows" 
  # @param size select "Size of the textarea" :size_options
  # @param resize select "Resize behavior" :resize_options
  # @param disabled [Boolean] toggle "Is the textarea disabled?"
  # @param readonly [Boolean] toggle "Is the textarea readonly?"
  # @param required [Boolean] toggle "Is the textarea required?"
  # @param description "Optional description text"
  # @param error_message "Optional error message"
  def playground(label: "Your Message", placeholder: "Tell us what you think...", value: "", rows: 4, size: :default, resize: :vertical, disabled: false, readonly: false, required: false, description: "", error_message: "")
    render EldritchUi::TextareaComponent.new(
      name: "playground_textarea",
      label: label,
      placeholder: placeholder.present? ? placeholder : nil,
      value: value.present? ? value : nil,
      rows: rows,
      size: size,
      resize: resize,
      disabled: disabled,
      readonly: readonly,
      required: required,
      description: description.present? ? description : nil,
      error_message: error_message.present? ? error_message : nil
    )
  end

  # Default textarea
  # @!group Basic Examples
  def default
    render EldritchUi::TextareaComponent.new(
      name: "message",
      label: "Message"
    )
  end

  # Textarea with placeholder
  # @!group Basic Examples
  def with_placeholder
    render EldritchUi::TextareaComponent.new(
      name: "feedback",
      label: "Your Feedback",
      placeholder: "Tell us what you think about our service..."
    )
  end

  # Textarea with value
  # @!group Basic Examples
  def with_value
    render EldritchUi::TextareaComponent.new(
      name: "bio",
      label: "Biography",
      value: "I am a software developer with 5 years of experience in web development. I enjoy working with modern technologies and solving complex problems."
    )
  end

  # Textarea with description
  # @!group Basic Examples
  def with_description
    render EldritchUi::TextareaComponent.new(
      name: "description",
      label: "Description",
      placeholder: "Tell us about yourself",
      description: "This helpful message appears below the textarea"
    )
  end

  # Required textarea
  # @!group Basic Examples
  def required
    render EldritchUi::TextareaComponent.new(
      name: "terms_acceptance",
      label: "Terms Acceptance Statement",
      required: true,
      placeholder: "Please type 'I accept' to continue..."
    )
  end

  # Textarea with custom rows
  # @!group Basic Examples
  def custom_rows
    render EldritchUi::TextareaComponent.new(
      name: "large_content",
      label: "Large Content Area",
      rows: 8,
      placeholder: "This textarea has 8 rows instead of the default 4..."
    )
  end

  # Form field examples
  # @!group Form Examples
  def form_contact_message
    render EldritchUi::TextareaComponent.new(
      name: "contact[message]",
      label: "Your Message",
      required: true,
      rows: 6,
      placeholder: "Please describe your inquiry in detail...",
      description: "Provide as much detail as possible to help us assist you better."
    )
  end

  def form_product_review
    render EldritchUi::TextareaComponent.new(
      name: "review[content]",
      label: "Product Review",
      placeholder: "Share your thoughts about this product...",
      description: "Your review will help other customers make informed decisions.",
      rows: 5
    )
  end

  def form_support_ticket
    render EldritchUi::TextareaComponent.new(
      name: "ticket[description]",
      label: "Issue Description",
      required: true,
      placeholder: "Please describe the issue you're experiencing in detail...",
      description: "Include steps to reproduce the issue, error messages, and any relevant details.",
      rows: 8
    )
  end

  # Validation examples
  # @!group Error Examples
  def error_too_short
    render EldritchUi::TextareaComponent.new(
      name: "description_field",
      label: "Project Description",
      value: "Too short",
      error_message: "Description must be at least 50 characters long.",
      description: "Provide a detailed description of your project goals and requirements."
    )
  end

  def error_required_field
    render EldritchUi::TextareaComponent.new(
      name: "required_field",
      label: "Required Comments",
      required: true,
      error_message: "This field is required.",
      placeholder: "Please provide your comments..."
    )
  end

  def error_invalid_content
    render EldritchUi::TextareaComponent.new(
      name: "content_field",
      label: "Content",
      value: "This content contains forbidden words and characters that are not allowed.",
      error_message: "Content contains prohibited words or characters.",
      description: "Please review our content guidelines and modify your text accordingly."
    )
  end

  # Advanced examples
  # @!group Advanced Examples
  def with_custom_attributes
    render EldritchUi::TextareaComponent.new(
      name: "custom_textarea",
      label: "Textarea with custom attributes",
      placeholder: "Custom textarea",
      "data-testid": "custom-textarea",
      "data-analytics": "textarea-interaction",
      id: "custom-textarea-id",
      cols: 60
    )
  end

  def large_content_area
    render EldritchUi::TextareaComponent.new(
      name: "large_content",
      label: "Large Content Editor",
      size: :large,
      rows: 12,
      placeholder: "Start writing your content here...",
      description: "This is a large content area suitable for writing long-form content.",
      resize: :vertical
    )
  end

  def code_input_area
    render EldritchUi::TextareaComponent.new(
      name: "code_snippet",
      label: "Code Snippet",
      placeholder: "Paste your code here...",
      description: "Enter the code snippet you'd like to share or debug.",
      rows: 10,
      resize: :both,
      "spellcheck": "false",
      "autocomplete": "off"
    )
  end

  # Accessibility examples
  # @!group Accessibility Examples
  def accessible_with_aria_label
    render EldritchUi::TextareaComponent.new(
      name: "accessible_textarea",
      label: "Accessible textarea field",
      description: "This textarea demonstrates proper accessibility features.",
      placeholder: "Enter your detailed response here",
      "aria-label": "Provide detailed feedback in this text area"
    )
  end

  def accessible_form_field
    render EldritchUi::TextareaComponent.new(
      name: "form[additional_info]",
      label: "Additional Information",
      description: "Provide any additional information that might be relevant to your request.",
      placeholder: "Optional additional details...",
      rows: 6,
      "autocomplete": "off"
    )
  end

  # Long content examples
  # @!group Content Examples
  def with_long_content
    long_content = <<~TEXT
      This is a textarea with pre-filled long content to demonstrate how the component handles larger amounts of text.
      
      Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
      
      Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    TEXT

    render EldritchUi::TextareaComponent.new(
      name: "long_content",
      label: "Long Content Example",
      value: long_content.strip,
      description: "This example shows how the textarea handles longer text content."
    )
  end

  def empty_with_guidance
    render EldritchUi::TextareaComponent.new(
      name: "guided_input",
      label: "Essay Response",
      placeholder: "Write your essay response here. Consider including:\n\n• An introduction with your main thesis\n• Supporting arguments with evidence\n• A conclusion that summarizes your points\n\nAim for 300-500 words.",
      description: "Take your time to craft a thoughtful response.",
      rows: 10
    )
  end

  # @!group Layout Examples

  # Standalone textarea without attached label
  def standalone_textarea
    render EldritchUi::TextareaComponent.new(
      name: "standalone",
      label: "Standalone Textarea",
      placeholder: "This textarea has standalone styling",
      standalone: true,
      description: "This textarea uses standalone: true, so the label won't be attached to the textarea field"
    )
  end

  # Attached label example (default behavior)
  def attached_label
    render EldritchUi::TextareaComponent.new(
      name: "attached_example",
      label: "Attached Label",
      placeholder: "Label is attached to textarea field",
      rows: 3,
      description: "This is the default behavior - the label appears as an attached tab"
    )
  end

  # Standalone for forms with external labels
  def standalone_form_field
    render EldritchUi::TextareaComponent.new(
      name: "description",
      placeholder: "Enter description...",
      rows: 4,
      standalone: true
    )
  end

  # @!endgroup

  # @!group Validation Examples

  private

  def size_options
    [:small, :default, :large]
  end

  def resize_options
    [:none, :vertical, :horizontal, :both]
  end
end 