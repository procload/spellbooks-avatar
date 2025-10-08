# frozen_string_literal: true

# Lookbook previews for EldritchUi::CheckboxComponent
class EldritchUi::CheckboxComponentPreview < ViewComponent::Preview
  # 🎉 Checkbox playground! 🎉
  # -----------------------
  # You can use the controls in the 'Params' section
  # to set checkbox property values on the fly.
  #
  # @param label "Label text for the checkbox"
  # @param checked [Boolean] toggle "Is the checkbox checked?"
  # @param disabled [Boolean] toggle "Is the checkbox disabled?"
  # @param required [Boolean] toggle "Is the checkbox required?"
  # @param size select "Size of the checkbox" :size_options
  # @param description "Optional description text"
  # @param error_message "Optional error message"
  def playground(label: "I accept the terms", checked: false, disabled: false, required: false, size: :default, description: "", error_message: "")
    render EldritchUi::CheckboxComponent.new(
      name: "playground_checkbox",
      label: label,
      checked: checked,
      disabled: disabled,
      required: required,
      size: size,
      description: description.present? ? description : nil,
      error_message: error_message.present? ? error_message : nil
    )
  end

  # Default checkbox (unchecked)
  # @!group Basic Examples
  def default
    render EldritchUi::CheckboxComponent.new(
      name: "accept_terms",
      label: "I accept the terms and conditions"
    )
  end

  # Checked checkbox
  # @!group Basic Examples
  def checked
    render EldritchUi::CheckboxComponent.new(
      name: "newsletter",
      label: "Subscribe to newsletter",
      checked: true
    )
  end

  # Checkbox with description
  # @!group Basic Examples
  def with_description
    render EldritchUi::CheckboxComponent.new(
      name: "notifications",
      label: "Enable notifications",
      description: "Receive email notifications about important updates and changes to your account."
    )
  end

  # Required checkbox
  # @!group Basic Examples
  def required
    render EldritchUi::CheckboxComponent.new(
      name: "privacy_policy",
      label: "I have read and agree to the privacy policy",
      required: true
    )
  end

  # Form field examples
  # @!group Form Examples
  def form_preferences
    render EldritchUi::CheckboxComponent.new(
      name: "user[receive_marketing]",
      value: "1",
      label: "Receive marketing emails",
      description: "Get updates about new features, products, and special offers."
    )
  end

  def form_account_settings
    render EldritchUi::CheckboxComponent.new(
      name: "user[two_factor_enabled]",
      value: "true",
      label: "Enable two-factor authentication",
      description: "Add an extra layer of security to your account.",
      checked: true
    )
  end

  def form_required_consent
    render EldritchUi::CheckboxComponent.new(
      name: "consent[data_processing]",
      value: "agreed",
      label: "I consent to data processing",
      description: "We need your consent to process your personal data according to our privacy policy.",
      required: true
    )
  end

  # Error state examples
  # @!group Error Examples
  def error_missing_required
    render EldritchUi::CheckboxComponent.new(
      name: "required_field",
      label: "Required checkbox",
      required: true,
      error_message: "This field is required to continue."
    )
  end

  def error_validation_failed
    render EldritchUi::CheckboxComponent.new(
      name: "age_verification",
      label: "I am 18 years or older",
      error_message: "You must be at least 18 years old to use this service.",
      description: "Please confirm your age to proceed with registration."
    )
  end

  # Accessibility examples
  # @!group Accessibility Examples
  def accessible_with_custom_attributes
    render EldritchUi::CheckboxComponent.new(
      name: "custom_checkbox",
      label: "Custom checkbox with data attributes",
      "data-testid": "custom-checkbox",
      "data-analytics": "checkbox-interaction"
    )
  end

  private

  def size_options
    [:small, :default, :large]
  end
end 