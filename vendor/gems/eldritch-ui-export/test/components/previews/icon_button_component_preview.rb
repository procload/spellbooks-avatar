# frozen_string_literal: true

# Lookbook previews for EldritchUi::IconButtonComponent
class EldritchUi::IconButtonComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param icon_name select "Icon name" :icon_options
  # @param title "Button title (tooltip/aria)"
  # @param href "Optional link URL"
  def playground(icon_name: "pencil", title: "Edit", href: "")
    render EldritchUi::IconButtonComponent.new(
      icon_name: icon_name,
      title: title,
      href: href.present? ? href : nil
    )
  end

  # @!group Basic
  def button
    render EldritchUi::IconButtonComponent.new(icon_name: "check-circle", title: "Confirm")
  end

  def link
    render EldritchUi::IconButtonComponent.new(icon_name: "arrow-right", title: "Go to details", href: "/details")
  end

  def with_custom_attributes
    render EldritchUi::IconButtonComponent.new(icon_name: "printer", title: "Print", class: "ml-2", data: { testid: "print-btn" })
  end

  private

  def icon_options
    %w[
      light-bulb plus arrow-right academic-cap sparkles document-text photo printer clipboard-document-list check-circle login google
    ]
  end
end

