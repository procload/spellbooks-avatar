# frozen_string_literal: true

# Comprehensive preview showing how Eldritch UI components work together
# This demonstrates the unified Spellbooks design system with static examples (Rails 8 compatible)
class EldritchUi::ComponentSystemPreview < ViewComponent::Preview
  # Primary theme system showcase (Rails 8 compatible)
  # @!group Design System - Static
  def primary_theme_system
    render EldritchUi::ButtonComponent.new(
      label: "Primary Button",
      variant: :primary,
      size: :medium
    )
  end

  def primary_theme_pill
    render EldritchUi::PillComponent.new(
      text: "Primary Pill",
      interactive: true,
      value: "primary-pill",
      class: "eld-pill"
    )
  end

  def primary_theme_tag
    render EldritchUi::TagComponent.new(
      text: "Primary Tag",
      dismissible: true,
      value: "primary-tag",
      class: "eld-tag eld-tag--primary"
    )
  end

  # Secondary theme system showcase (Rails 8 compatible)
  # @!group Design System - Static
  def secondary_theme_system
    render EldritchUi::ButtonComponent.new(
      label: "Secondary Button",
      variant: :secondary,
      size: :medium
    )
  end

  def secondary_theme_pill
    render EldritchUi::PillComponent.new(
      text: "Secondary Pill",
      interactive: true,
      value: "secondary-pill",
      class: "eld-pill eld-pill--secondary"
    )
  end

  def secondary_theme_tag
    render EldritchUi::TagComponent.new(
      text: "Secondary Tag",
      dismissible: true,
      value: "secondary-tag",
      class: "eld-tag eld-tag--secondary"
    )
  end

  # Dark theme system showcase (Rails 8 compatible)
  # @!group Design System - Static
  def dark_theme_system
    render EldritchUi::ButtonComponent.new(
      label: "Dark Button",
      variant: :dark,
      size: :medium
    )
  end

  def dark_theme_pill
    render EldritchUi::PillComponent.new(
      text: "Dark Pill",
      interactive: true,
      value: "dark-pill",
      class: "eld-pill eld-pill--dark"
    )
  end

  def dark_theme_tag
    render EldritchUi::TagComponent.new(
      text: "Dark Tag",
      dismissible: true,
      value: "dark-tag",
      class: "eld-tag eld-tag--dark"
    )
  end

  # Size comparisons (Rails 8 compatible)
  # @!group Size Comparison - Static
  def small_size_button
    render EldritchUi::ButtonComponent.new(
      label: "Small Button",
      variant: :primary,
      size: :small
    )
  end

  def small_size_pill
    render EldritchUi::PillComponent.new(
      text: "Small Pill",
      interactive: true,
      value: "small-pill",
      class: "eld-pill eld-pill--small"
    )
  end

  def small_size_tag
    render EldritchUi::TagComponent.new(
      text: "Small Tag",
      dismissible: true,
      value: "small-tag",
      class: "eld-tag eld-tag--small"
    )
  end

  def large_size_button
    render EldritchUi::ButtonComponent.new(
      label: "Large Button",
      variant: :primary,
      size: :large
    )
  end

  def large_size_pill
    render EldritchUi::PillComponent.new(
      text: "Large Pill",
      interactive: true,
      value: "large-pill",
      class: "eld-pill eld-pill--large"
    )
  end

  def large_size_tag
    render EldritchUi::TagComponent.new(
      text: "Large Tag",
      dismissible: true,
      value: "large-tag",
      class: "eld-tag eld-tag--large"
    )
  end

  # Interactive states (Rails 8 compatible)
  # @!group Interactive States - Static
  def interactive_button_normal
    render EldritchUi::ButtonComponent.new(
      label: "Normal Button",
      variant: :primary
    )
  end

  def interactive_button_pressed
    render EldritchUi::ButtonComponent.new(
      label: "Pressed Button",
      variant: :primary,
      class: "eld-button--pressed"
    )
  end

  def interactive_pill_normal
    render EldritchUi::PillComponent.new(
      text: "Normal Pill",
      interactive: true,
      value: "normal-pill"
    )
  end

  def interactive_pill_selected
    render EldritchUi::PillComponent.new(
      text: "Selected Pill",
      interactive: true,
      selected: true,
      value: "selected-pill"
    )
  end

  def interactive_tag_normal
    render EldritchUi::TagComponent.new(
      text: "Normal Tag",
      interactive: true,
      value: "normal-tag",
      class: "eld-tag eld-tag--interactive"
    )
  end

  def interactive_tag_selected
    render EldritchUi::TagComponent.new(
      text: "Selected Tag",
      interactive: true,
      selected: true,
      value: "selected-tag",
      class: "eld-tag eld-tag--interactive eld-tag--selected"
    )
  end
end 