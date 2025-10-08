# frozen_string_literal: true

# Lookbook previews for EldritchUi::TextInputComponent
class EldritchUi::TextInputComponentPreview < ViewComponent::Preview
  # 🎉 Text Input playground! 🎉
  # -----------------------
  # You can use the controls in the 'Params' section
  # to set input property values on the fly.
  #
  # @param label "Label text for the input"
  # @param placeholder "Placeholder text"
  # @param value "Current value of the input"
  # @param type select "Type of input" :type_options
  # @param size select "Size of the input" :size_options
  # @param disabled [Boolean] toggle "Is the input disabled?"
  # @param readonly [Boolean] toggle "Is the input readonly?"
  # @param required [Boolean] toggle "Is the input required?"
  # @param description "Optional description text"
  # @param error_message "Optional error message"
  def playground(label: "Email Address", placeholder: "Enter your email", value: "", type: :email, size: :default, disabled: false, readonly: false, required: false, description: "", error_message: "")
    render EldritchUi::TextInputComponent.new(
      name: "playground_input",
      label: label,
      placeholder: placeholder.present? ? placeholder : nil,
      value: value.present? ? value : nil,
      type: type,
      size: size,
      disabled: disabled,
      readonly: readonly,
      required: required,
      description: description.present? ? description : nil,
      error_message: error_message.present? ? error_message : nil
    )
  end

  # Default text input
  # @!group Basic Examples
  def default
    render EldritchUi::TextInputComponent.new(
      name: "username",
      label: "Username"
    )
  end

  # Input with placeholder
  # @!group Basic Examples
  def with_placeholder
    render EldritchUi::TextInputComponent.new(
      name: "email",
      label: "Email Address",
      placeholder: "Enter your email address"
    )
  end

  # Input with value
  # @!group Basic Examples
  def with_value
    render EldritchUi::TextInputComponent.new(
      name: "prefilled",
      label: "Prefilled Input",
      value: "This field has a value"
    )
  end

  # Input with description
  # @!group Basic Examples
  def with_description
    render EldritchUi::TextInputComponent.new(
      name: "password",
      type: :password,
      label: "Password",
      description: "Must be at least 8 characters long and include numbers and special characters."
    )
  end

  # Required input
  # @!group Basic Examples
  def required
    render EldritchUi::TextInputComponent.new(
      name: "company_name",
      label: "Company Name",
      required: true,
      placeholder: "Enter your company name"
    )
  end

  # Input types
  # @!group Type Examples
  def type_email
    render EldritchUi::TextInputComponent.new(
      name: "user_email",
      type: :email,
      label: "Email",
      placeholder: "user@example.com"
    )
  end

  def type_password
    render EldritchUi::TextInputComponent.new(
      name: "user_password",
      type: :password,
      label: "Password",
      placeholder: "Enter a secure password"
    )
  end

  def type_url
    render EldritchUi::TextInputComponent.new(
      name: "website",
      type: :url,
      label: "Website",
      placeholder: "https://www.example.com"
    )
  end

  def type_tel
    render EldritchUi::TextInputComponent.new(
      name: "phone",
      type: :tel,
      label: "Phone Number",
      placeholder: "(555) 123-4567"
    )
  end

  def type_search
    render EldritchUi::TextInputComponent.new(
      name: "query",
      type: :search,
      label: "Search",
      placeholder: "Search for anything..."
    )
  end

  def type_number
    render EldritchUi::TextInputComponent.new(
      name: "age",
      type: :number,
      label: "Age",
      placeholder: "25"
    )
  end

  # Form field examples
  # @!group Form Examples
  def form_user_registration
    render EldritchUi::TextInputComponent.new(
      name: "user[email]",
      type: :email,
      label: "Email Address",
      required: true,
      placeholder: "your.email@example.com",
      description: "We'll use this email to send you important updates."
    )
  end

  def form_profile_settings
    render EldritchUi::TextInputComponent.new(
      name: "profile[display_name]",
      label: "Display Name",
      value: "John Doe",
      description: "This name will be visible to other users.",
      placeholder: "Enter your display name"
    )
  end

  def form_contact_information
    render EldritchUi::TextInputComponent.new(
      name: "contact[phone]",
      type: :tel,
      label: "Phone Number",
      placeholder: "+1 (555) 123-4567",
      description: "Include country code for international numbers."
    )
  end

  # Validation examples
  # @!group Error Examples
  def error_invalid_email
    render EldritchUi::TextInputComponent.new(
      name: "email_field",
      type: :email,
      label: "Email Address",
      value: "invalid.email",
      error_message: "Please enter a valid email address.",
      required: true
    )
  end

  def error_too_short
    render EldritchUi::TextInputComponent.new(
      name: "username_field",
      label: "Username",
      value: "ab",
      error_message: "Username must be at least 3 characters long.",
      description: "Choose a unique username that others will recognize."
    )
  end

  def error_required_field
    render EldritchUi::TextInputComponent.new(
      name: "required_field",
      label: "Required Field",
      required: true,
      error_message: "This field is required.",
      placeholder: "Cannot be empty"
    )
  end

  # Advanced examples
  # @!group Advanced Examples
  def with_custom_attributes
    render EldritchUi::TextInputComponent.new(
      name: "custom_input",
      label: "Input with custom attributes",
      placeholder: "Custom input",
      "data-testid": "custom-text-input",
      "data-analytics": "text-input-interaction",
      id: "custom-input-id"
    )
  end

  def search_with_large_size
    render EldritchUi::TextInputComponent.new(
      name: "search_query",
      type: :search,
      label: "Search Everything",
      size: :large,
      placeholder: "Type your search query here...",
      description: "Search across all content, users, and documents."
    )
  end

  def number_input_with_constraints
    render EldritchUi::TextInputComponent.new(
      name: "quantity",
      type: :number,
      label: "Quantity",
      value: "1",
      description: "Enter a number between 1 and 100.",
      min: "1",
      max: "100"
    )
  end

  # Accessibility examples
  # @!group Accessibility Examples
  def accessible_with_aria_label
    render EldritchUi::TextInputComponent.new(
      name: "accessible_input",
      label: "Accessible input field",
      description: "This input demonstrates proper accessibility features.",
      placeholder: "Type something here",
      "aria-label": "Enter your response in this text field"
    )
  end

  def accessible_form_field
    render EldritchUi::TextInputComponent.new(
      name: "form[billing_address]",
      label: "Billing Address",
      required: true,
      description: "Enter your complete billing address for invoice processing.",
      placeholder: "123 Main St, City, State 12345",
      "autocomplete": "billing street-address"
    )
  end

  # @!group Layout Examples

  # Standalone input without attached label
  def standalone_input
    render EldritchUi::TextInputComponent.new(
      name: "standalone",
      label: "Standalone Input",
      placeholder: "This input has standalone styling",
      standalone: true,
      description: "This input uses standalone: true, so the label won't be attached to the input field"
    )
  end

  # Attached label example (default behavior)
  def attached_label
    render EldritchUi::TextInputComponent.new(
      name: "attached_example",
      label: "Attached Label",
      placeholder: "Label is attached to input field",
      description: "This is the default behavior - the label appears as an attached tab"
    )
  end

  # Standalone for answer editing (like in question forms)
  def standalone_answer_input
    render EldritchUi::TextInputComponent.new(
      name: "answer_text",
      placeholder: "Enter answer text",
      standalone: true
    )
  end

  # @!endgroup

  # @!group Types Examples

  private

  def type_options
    [:text, :email, :password, :url, :tel, :search, :number]
  end

  def size_options
    [:small, :default, :large]
  end
end 