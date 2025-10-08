# frozen_string_literal: true

# Lookbook previews for EldritchUi::ButtonComponent
class EldritchUi::ButtonComponentPreview < ViewComponent::Preview
  # 🎉 Button playground! 🎉
  # -----------------------
  # You can use the controls in the 'Params' section
  # to set button property values on the fly.
  #
  # @param label "Button text content"
  # @param variant select "Visual style variant" :variant_options
  # @param size select "Size of the button" :size_options
  # @param disabled [Boolean] toggle "Is the button disabled?"
  # @param href "Optional URL for link behavior"
  # @param type select "Button type attribute" :type_options
  def playground(label: "Click me", variant: :primary, size: :medium, disabled: false, href: "", type: :button)
    render EldritchUi::ButtonComponent.new(
      label: label,
      variant: variant,
      size: size,
      disabled: disabled,
      href: href.present? ? href : nil,
      type: type
    )
  end

  # Default button with primary styling
  # @!group Basic Examples
  def default
    render EldritchUi::ButtonComponent.new(label: "Default Button")
  end

  # Button variants showcase
  # @!group Variants
  def primary
    render EldritchUi::ButtonComponent.new(
      label: "Primary Button",
      variant: :primary
    )
  end

  def secondary
    render EldritchUi::ButtonComponent.new(
      label: "Secondary Button", 
      variant: :secondary
    )
  end

  def dark
    render EldritchUi::ButtonComponent.new(
      label: "Dark Button",
      variant: :dark
    )
  end

  def outline
    render EldritchUi::ButtonComponent.new(
      label: "Outline Button",
      variant: :outline
    )
  end

  def ghost
    render EldritchUi::ButtonComponent.new(
      label: "Ghost Button",
      variant: :ghost
    )
  end

  def warning
    render EldritchUi::ButtonComponent.new(
      label: "Warning Button",
      variant: :warning
    )
  end

  # Button sizes showcase
  # @!group Sizes
  def small
    render EldritchUi::ButtonComponent.new(
      label: "Small Button",
      size: :small
    )
  end

  def medium
    render EldritchUi::ButtonComponent.new(
      label: "Medium Button",
      size: :medium
    )
  end

  def large
    render EldritchUi::ButtonComponent.new(
      label: "Large Button",
      size: :large
    )
  end

  # Button states
  # @!group States
  def disabled_button
    render EldritchUi::ButtonComponent.new(
      label: "Disabled Button",
      disabled: true
    )
  end

  def disabled_link
    render EldritchUi::ButtonComponent.new(
      label: "Disabled Link",
      href: "/disabled",
      disabled: true
    )
  end

  # Link buttons (rendered as anchor tags)
  # @!group Links
  def link_button
    render EldritchUi::ButtonComponent.new(
      label: "Link Button",
      href: "/example"
    )
  end

  def external_link
    render EldritchUi::ButtonComponent.new(
      label: "External Link",
      href: "https://example.com",
      target: "_blank",
      rel: "noopener"
    )
  end

  # Form buttons
  # @!group Forms
  def submit_button
    render EldritchUi::ButtonComponent.new(
      label: "Submit Form",
      type: "submit",
      variant: :primary
    )
  end

  def reset_button
    render EldritchUi::ButtonComponent.new(
      label: "Reset Form",
      type: "reset",
      variant: :outline
    )
  end

  # Toggle buttons with state management
  # @!group Toggle Buttons
  def toggle_unpressed
    render EldritchUi::ButtonComponent.new(
      label: "Toggle Me",
      toggle: true,
      pressed: false
    )
  end

  def toggle_pressed
    render EldritchUi::ButtonComponent.new(
      label: "I'm Pressed",
      toggle: true,
      pressed: true
    )
  end

  # Primary toggle variants - unpressed
  def toggle_primary_unpressed
    render EldritchUi::ButtonComponent.new(
      label: "Primary Toggle",
      variant: :primary,
      toggle: true,
      pressed: false
    )
  end

  # Primary toggle variants - pressed
  def toggle_primary_pressed
    render EldritchUi::ButtonComponent.new(
      label: "Primary Toggle (Pressed)",
      variant: :primary,
      toggle: true,
      pressed: true
    )
  end

  # Secondary toggle variants - unpressed
  def toggle_secondary_unpressed
    render EldritchUi::ButtonComponent.new(
      label: "Secondary Toggle",
      variant: :secondary,
      toggle: true,
      pressed: false
    )
  end

  # Secondary toggle variants - pressed
  def toggle_secondary_pressed
    render EldritchUi::ButtonComponent.new(
      label: "Secondary Toggle (Pressed)",
      variant: :secondary,
      toggle: true,
      pressed: true
    )
  end

  # Dark toggle variants - unpressed
  def toggle_dark_unpressed
    render EldritchUi::ButtonComponent.new(
      label: "Dark Toggle",
      variant: :dark,
      toggle: true,
      pressed: false
    )
  end

  # Dark toggle variants - pressed
  def toggle_dark_pressed
    render EldritchUi::ButtonComponent.new(
      label: "Dark Toggle (Pressed)",
      variant: :dark,
      toggle: true,
      pressed: true
    )
  end

  # Outline toggle variants - unpressed
  def toggle_outline_unpressed
    render EldritchUi::ButtonComponent.new(
      label: "Outline Toggle",
      variant: :outline,
      toggle: true,
      pressed: false
    )
  end

  # Outline toggle variants - pressed
  def toggle_outline_pressed
    render EldritchUi::ButtonComponent.new(
      label: "Outline Toggle (Pressed)",
      variant: :outline,
      toggle: true,
      pressed: true
    )
  end

  # Ghost toggle variants - unpressed
  def toggle_ghost_unpressed
    render EldritchUi::ButtonComponent.new(
      label: "Ghost Toggle",
      variant: :ghost,
      toggle: true,
      pressed: false
    )
  end

  # Ghost toggle variants - pressed
  def toggle_ghost_pressed
    render EldritchUi::ButtonComponent.new(
      label: "Ghost Toggle (Pressed)",
      variant: :ghost,
      toggle: true,
      pressed: true
    )
  end

  # Toggle link button - unpressed
  def toggle_link_unpressed
    render EldritchUi::ButtonComponent.new(
      label: "Toggle Link (Unpressed)",
      href: "/toggle-example",
      toggle: true,
      pressed: false
    )
  end

  # Toggle link button - pressed  
  def toggle_link_pressed
    render EldritchUi::ButtonComponent.new(
      label: "Toggle Link (Pressed)",
      href: "/toggle-example",
      toggle: true,
      pressed: true
    )
  end

  # Button with custom content using slots
  # @!group Advanced
  def with_icon_content
    render EldritchUi::ButtonComponent.new(variant: :primary) do
      "<span class='eld-btn__icon eld-btn__icon--start'>⭐</span>Star Button".html_safe
    end
  end

  # Interactive demo
  # @!group Interactive
  def interactive_demo
    render EldritchUi::ButtonComponent.new(
      label: "Toggle Demo",
      toggle: true,
      pressed: false,
      id: "toggle-demo-interactive"
    )
  end

  # Basic form example
  def basic_form_button
    render EldritchUi::ButtonComponent.new(
      label: "Save Changes",
      type: "submit",
      variant: :primary
    )
  end

  private

  def variant_options
    [:primary, :secondary, :dark, :outline, :ghost, :warning]
  end

  def size_options
    [:small, :medium, :large]
  end

  def type_options
    [:button, :submit, :reset]
  end
end