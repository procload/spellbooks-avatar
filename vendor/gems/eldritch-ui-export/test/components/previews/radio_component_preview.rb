# frozen_string_literal: true

# Lookbook previews for EldritchUi::RadioComponent
class EldritchUi::RadioComponentPreview < ViewComponent::Preview
  # Default radio button
  # @!group Basic Examples
  def default
    render EldritchUi::RadioComponent.new(
      label: "Default Option",
      name: "example",
      value: "default"
    )
  end

  # Radio states
  # @!group States
  def checked_radio
    render EldritchUi::RadioComponent.new(
      label: "Selected Option",
      name: "example",
      value: "selected",
      checked: true
    )
  end

  def disabled_radio
    render EldritchUi::RadioComponent.new(
      label: "Disabled Option",
      name: "example",
      value: "disabled",
      disabled: true
    )
  end

  def checked_and_disabled
    render EldritchUi::RadioComponent.new(
      label: "Checked & Disabled",
      name: "example",
      value: "checked_disabled",
      checked: true,
      disabled: true
    )
  end

  # Radio with custom content using slots
  # @!group Advanced
  def with_rich_content
    render EldritchUi::RadioComponent.new(
      name: "rich_content",
      value: "rich"
    ) do
      content_tag(:div, class: "flex items-center space-x-2") do
        content_tag(:span, "🎨", class: "text-xl") +
        content_tag(:div) do
          content_tag(:div, "Design Mode", class: "font-semibold") +
          content_tag(:div, "Advanced styling options", class: "text-sm text-gray-600")
        end
      end
    end
  end

  def with_description
    render EldritchUi::RadioComponent.new(
      name: "description",
      value: "with_desc"
    ) do
      content_tag(:div) do
        content_tag(:div, "Option with Description", class: "font-medium") +
        content_tag(:div, "This option includes additional explanatory text", class: "text-sm text-gray-500 mt-1")
      end
    end
  end

  # Form integration examples
  # @!group Form Examples
  def form_example
    render EldritchUi::RadioComponent.new(
      label: "Email notifications",
      name: "notification_method",
      value: "email",
      checked: true
    )
  end

  # Styling and layout examples
  # @!group Layout Examples
  def horizontal_group
    render EldritchUi::RadioComponent.new(
      label: "Medium",
      name: "size",
      value: "m",
      checked: true
    )
  end

  def custom_styling
    render EldritchUi::RadioComponent.new(
      label: "Custom Styled Radio",
      name: "custom",
      value: "styled",
      class: "p-4 border border-gray-300 rounded-lg hover:bg-gray-50",
      data: { testid: "custom-radio" }
    )
  end

  # All states in one view for comparison
  # @!group Comparison
  def all_states
    render EldritchUi::RadioComponent.new(
      label: "Checked Radio",
      name: "comparison",
      value: "state_1",
      checked: true,
      disabled: false
    )
  end

  # Radio button group patterns
  # @!group Patterns
  def rating_scale
    render EldritchUi::RadioComponent.new(
      label: "Very Satisfied",
      name: "satisfaction",
      value: "5"
    )
  end

  def payment_methods
    render EldritchUi::RadioComponent.new(
      label: "💳 Credit Card",
      name: "payment_method",
      value: "credit_card"
    )
  end

  # Accessibility demonstration
  # @!group Accessibility
  def accessibility_example
    render EldritchUi::RadioComponent.new(
      label: "I understand accessibility is important",
      name: "accessibility_commitment",
      value: "understand"
    )
  end

  # Interactive demonstration
  # @!group Interactive
  def interactive_example
    render EldritchUi::RadioComponent.new(
      label: "Option A",
      name: "interactive_demo",
      value: "a",
      data: { 
        action: "change->demo#handleRadioChange",
        option: "a"
      }
    )
  end
end