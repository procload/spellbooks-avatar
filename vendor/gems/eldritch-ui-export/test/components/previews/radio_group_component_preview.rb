# frozen_string_literal: true

# Lookbook previews for EldritchUi::RadioGroupComponent
class EldritchUi::RadioGroupComponentPreview < ViewComponent::Preview
  # Default radio group with options array
  # @!group Basic Examples
  def default
    options = [
      { label: "Option 1", value: "opt1" },
      { label: "Option 2", value: "opt2" },
      { label: "Option 3", value: "opt3" }
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "Choose one option",
      name: "example_choice",
      options: options
    )
  end

  # Radio group with preselected value
  # @!group Basic Examples
  def with_selected_value
    options = [
      { label: "Small", value: "s" },
      { label: "Medium", value: "m" },
      { label: "Large", value: "l" }
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "Select size",
      name: "size_choice",
      value: "m", # Preselect medium
      options: options
    )
  end

  # Different option formats
  # @!group Option Formats
  def simple_string_options
    options = ["Red", "Green", "Blue", "Yellow"]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "Pick a color",
      name: "color_simple",
      options: options
    )
  end

  def array_tuple_options
    options = [
      ["Extra Small", "xs"],
      ["Small", "s"],
      ["Medium", "m"],
      ["Large", "l"],
      ["Extra Large", "xl"]
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "T-shirt size",
      name: "tshirt_size",
      options: options
    )
  end

  def mixed_format_options
    options = [
      "Basic Plan",
      ["Standard Plan", "standard"],
      { label: "Premium Plan", value: "premium" },
      { label: "Enterprise Plan", value: "enterprise", disabled: true }
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "Subscription Plan",
      name: "plan_mixed",
      options: options
    )
  end

  # Radio group with disabled options
  # @!group States
  def with_disabled_options
    options = [
      { label: "Available Option", value: "available" },
      { label: "Another Available", value: "available2" },
      { label: "Disabled Option", value: "disabled", disabled: true },
      { label: "Also Disabled", value: "disabled2", disabled: true }
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "Options with some disabled",
      name: "mixed_disabled",
      options: options
    )
  end

  # Radio group using content block instead of options
  # @!group Advanced
  def with_custom_content
    render EldritchUi::RadioGroupComponent.new(
      legend: "Custom radio group",
      name: "custom_radios"
    ) do
      render(EldritchUi::RadioComponent.new(
        name: "custom_radios",
        value: "home"
      )) do
        content_tag(:div) do
          content_tag(:div, "🏠 Home Delivery", class: "font-medium") +
          content_tag(:div, "Delivered to your door", class: "text-sm text-gray-500")
        end
      end
    end
  end

  # Hidden legend example
  # @!group Layout
  def hidden_legend
    options = ["Option A", "Option B", "Option C"]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "", # Empty legend will be hidden
      name: "hidden_legend",
      options: options
    )
  end

  # Form integration examples
  # @!group Form Examples
  def contact_preferences
    options = [
      { label: "📧 Email only", value: "email" },
      { label: "📱 SMS only", value: "sms" },
      { label: "📞 Phone calls", value: "phone" },
      { label: "📮 Postal mail", value: "mail" },
      { label: "🚫 No contact", value: "none" }
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "How would you like us to contact you?",
      name: "contact_preference",
      value: "email",
      options: options
    )
  end

  def payment_method_selection
    options = [
      { label: "💳 Credit Card", value: "credit" },
      { label: "💰 Debit Card", value: "debit" },
      { label: "🏦 Bank Transfer", value: "bank" },
      { label: "📱 Digital Wallet", value: "digital" },
      { label: "💵 Cash on Delivery", value: "cod" }
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "Choose payment method",
      name: "payment_method",
      options: options
    )
  end

  def user_role_selection
    options = [
      { label: "👤 Regular User", value: "user" },
      { label: "✏️ Editor", value: "editor" },
      { label: "👑 Administrator", value: "admin", disabled: true }, # Admin might be restricted
      { label: "👁️ Viewer Only", value: "viewer" }
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "Select user role",
      name: "user_role",
      value: "user",
      options: options
    )
  end

  # Survey and rating examples
  # @!group Survey Examples
  def satisfaction_rating
    options = [
      { label: "😍 Very Satisfied", value: "5" },
      { label: "😊 Satisfied", value: "4" },
      { label: "😐 Neutral", value: "3" },
      { label: "😞 Dissatisfied", value: "2" },
      { label: "😡 Very Dissatisfied", value: "1" }
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "How satisfied are you with our service?",
      name: "satisfaction",
      options: options
    )
  end

  def frequency_selection
    options = [
      { label: "Daily", value: "daily" },
      { label: "Weekly", value: "weekly" },
      { label: "Monthly", value: "monthly" },
      { label: "Quarterly", value: "quarterly" },
      { label: "Annually", value: "annually" },
      { label: "Never", value: "never" }
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "How often would you like to receive updates?",
      name: "frequency",
      value: "monthly",
      options: options
    )
  end

  # Complete form example
  # @!group Complete Examples
  def complete_form_example
    render EldritchUi::RadioGroupComponent.new(
      legend: "Account Type",
      name: "account_type",
      value: "personal",
      options: [
        { label: "Personal Account", value: "personal" },
        { label: "Business Account", value: "business" },
        { label: "Organization", value: "organization" }
      ]
    )
  end

  # Custom styling example
  # @!group Styling
  def custom_styled_group
    options = [
      { label: "🎨 Creative", value: "creative" },
      { label: "🔧 Technical", value: "technical" },
      { label: "💼 Business", value: "business" },
      { label: "🎯 Marketing", value: "marketing" }
    ]
    
    render EldritchUi::RadioGroupComponent.new(
      legend: "What's your focus area?",
      name: "focus_area",
      options: options,
      class: "p-4 border border-gray-200 rounded-lg bg-gray-50",
      data: { testid: "focus-area-group" }
    )
  end

  # Accessibility demonstration
  # @!group Accessibility
  def accessibility_example
    render EldritchUi::RadioGroupComponent.new(
      legend: "Accessibility Test Group",
      name: "accessibility_test",
      options: [
        { label: "I can navigate with keyboard", value: "keyboard" },
        { label: "I can use with screen reader", value: "screen_reader" },
        { label: "Focus indicators are visible", value: "focus" }
      ]
    )
  end

  # All variations for comparison
  # @!group Comparison
  def all_variations
    render EldritchUi::RadioGroupComponent.new(
      legend: "Hash Format",
      name: "hash_demo",
      options: [
        { label: "Option 1", value: "opt1" },
        { label: "Option 2", value: "opt2", disabled: true }
      ]
    )
  end
end