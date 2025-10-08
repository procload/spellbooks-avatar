# frozen_string_literal: true

class EldritchUi::FieldComponentPreview < ViewComponent::Preview
  # @label Interactive Playground
  # @param label_text text "Label text"
  # @param message text "Validation message"
  # @param status select { choices: [none, error, success, warning, info] } "Status"
  # @param required toggle "Required field"
  # @param input_type select { choices: [text, select, textarea] } "Input type"
  def playground(
    label_text: "Email Address",
    message: "",
    status: "none",
    required: false,
    input_type: "text"
  )
    status_value = status == "none" ? nil : status.to_sym
    
    render EldritchUi::FieldComponent.new(
      status: status_value,
      message: message.presence,
      required: required
    ) do |field|
      field.with_label do
        content_tag(:label, label_text, for: "playground-input")
      end
      
      field.with_input do
        case input_type
        when "text"
          render EldritchUi::TextInputComponent.new(
            id: "playground-input",
            name: "email",
            placeholder: "Enter your email..."
          )
        when "select"
          render EldritchUi::SelectComponent.new(
            id: "playground-input",
            name: "country",
            options: [
              { value: "us", label: "United States" },
              { value: "ca", label: "Canada" },
              { value: "uk", label: "United Kingdom" }
            ],
            placeholder: "Choose a country..."
          )
        when "textarea"
          render EldritchUi::TextareaComponent.new(
            id: "playground-input",
            name: "description",
            placeholder: "Enter description..."
          )
        end
      end
    end
  end

  # @!group Basic Examples

  # @label Text Input Field
  def text_input
    render EldritchUi::FieldComponent.new do |field|
      field.with_label do
        content_tag(:label, "Full Name", for: "name-input")
      end
      
      field.with_input do
        render EldritchUi::TextInputComponent.new(
          id: "name-input",
          name: "name",
          placeholder: "Enter your full name..."
        )
      end
    end
  end

  # @label Select Field
  def select_field
    render EldritchUi::FieldComponent.new do |field|
      field.with_label do
        content_tag(:label, "Country", for: "country-select")
      end
      
      field.with_input do
        render EldritchUi::SelectComponent.new(
          id: "country-select",
          name: "country",
          options: [
            { value: "us", label: "United States" },
            { value: "ca", label: "Canada" },
            { value: "uk", label: "United Kingdom" },
            { value: "de", label: "Germany" },
            { value: "fr", label: "France" }
          ],
          placeholder: "Choose your country..."
        )
      end
    end
  end

  # @label Textarea Field
  def textarea_field
    render EldritchUi::FieldComponent.new do |field|
      field.with_label do
        content_tag(:label, "Description", for: "description-textarea")
      end
      
      field.with_input do
        render EldritchUi::TextareaComponent.new(
          id: "description-textarea",
          name: "description",
          placeholder: "Tell us about yourself...",
          rows: 4
        )
      end
    end
  end

  # @!endgroup

  # @!group Validation States

  # @label Error State
  def error_state
    render EldritchUi::FieldComponent.new(
      status: :error,
      message: "This field is required and cannot be empty."
    ) do |field|
      field.with_label do
        content_tag(:label, "Email Address", for: "error-email")
      end
      
      field.with_input do
        render EldritchUi::TextInputComponent.new(
          id: "error-email",
          name: "email",
          placeholder: "Enter your email..."
        )
      end
    end
  end

  # @label Success State
  def success_state
    render EldritchUi::FieldComponent.new(
      status: :success,
      message: "Email address is valid and available."
    ) do |field|
      field.with_label do
        content_tag(:label, "Email Address", for: "success-email")
      end
      
      field.with_input do
        render EldritchUi::TextInputComponent.new(
          id: "success-email",
          name: "email",
          value: "user@example.com"
        )
      end
    end
  end

  # @label Warning State
  def warning_state
    render EldritchUi::FieldComponent.new(
      status: :warning,
      message: "This email domain is not commonly used."
    ) do |field|
      field.with_label do
        content_tag(:label, "Email Address", for: "warning-email")
      end
      
      field.with_input do
        render EldritchUi::TextInputComponent.new(
          id: "warning-email",
          name: "email",
          value: "user@unusual-domain.xyz"
        )
      end
    end
  end

  # @label Info State
  def info_state
    render EldritchUi::FieldComponent.new(
      status: :info,
      message: "We'll send a confirmation email to this address."
    ) do |field|
      field.with_label do
        content_tag(:label, "Email Address", for: "info-email")
      end
      
      field.with_input do
        render EldritchUi::TextInputComponent.new(
          id: "info-email",
          name: "email",
          placeholder: "Enter your email..."
        )
      end
    end
  end

  # @!endgroup

  # @!group Required Fields

  # @label Required Field
  def required_field
    render EldritchUi::FieldComponent.new(required: true) do |field|
      field.with_label do
        content_tag(:label, "Password", for: "required-password")
      end
      
      field.with_input do
        render EldritchUi::TextInputComponent.new(
          id: "required-password",
          name: "password",
          type: "password",
          placeholder: "Enter your password..."
        )
      end
    end
  end

  # @label Required with Error
  def required_with_error
    render EldritchUi::FieldComponent.new(
      required: true,
      status: :error,
      message: "Password is required and must be at least 8 characters."
    ) do |field|
      field.with_label do
        content_tag(:label, "Password", for: "required-error-password")
      end
      
      field.with_input do
        render EldritchUi::TextInputComponent.new(
          id: "required-error-password",
          name: "password",
          type: "password",
          placeholder: "Enter your password..."
        )
      end
    end
  end

  # @!endgroup

  # @!group Advanced

  # @label Custom Message Slot
  def custom_message
    render EldritchUi::FieldComponent.new(status: :info) do |field|
      field.with_label do
        content_tag(:label, "Username", for: "username-input")
      end
      
      field.with_input do
        render EldritchUi::TextInputComponent.new(
          id: "username-input",
          name: "username",
          placeholder: "Choose a username..."
        )
      end
      
      field.with_message do
        content_tag(:div, class: "flex items-center gap-2") do
          content_tag(:span, "ℹ️") +
          content_tag(:span, "Username must be 3-20 characters and contain only letters, numbers, and underscores.")
        end
      end
    end
  end

  # @label Form Integration
  def form_integration
    render_with_template(template: "eldritch_ui/field_component_preview/form_integration")
  end

  # @!endgroup
end 