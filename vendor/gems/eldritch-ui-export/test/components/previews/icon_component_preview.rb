# frozen_string_literal: true

module EldritchUi
  # @label Icon
  class IconComponentPreview < ViewComponent::Preview
    # @label Default
    def default
      render EldritchUi::IconComponent.new(name: "plus")
    end

    # @label All Icons - Plus
    def icon_plus
      render EldritchUi::IconComponent.new(name: "plus", size: "lg")
    end

    # @label All Icons - Light Bulb
    def icon_light_bulb
      render EldritchUi::IconComponent.new(name: "light-bulb", size: "lg")
    end

    # @label All Icons - Arrow Right
    def icon_arrow_right
      render EldritchUi::IconComponent.new(name: "arrow-right", size: "lg")
    end

    # @label All Icons - Academic Cap
    def icon_academic_cap
      render EldritchUi::IconComponent.new(name: "academic-cap", size: "lg")
    end

    # @label All Icons - Sparkles
    def icon_sparkles
      render EldritchUi::IconComponent.new(name: "sparkles", size: "lg")
    end

    # @label All Icons - Document Text
    def icon_document_text
      render EldritchUi::IconComponent.new(name: "document-text", size: "lg")
    end

    # @label All Icons - Photo
    def icon_photo
      render EldritchUi::IconComponent.new(name: "photo", size: "lg")
    end

    # @label All Icons - Clipboard Document List
    def icon_clipboard_document_list
      render EldritchUi::IconComponent.new(name: "clipboard-document-list", size: "lg")
    end

    # @label All Icons - Check Circle
    def icon_check_circle
      render EldritchUi::IconComponent.new(name: "check-circle", size: "lg")
    end

    # @label All Icons - Login
    def icon_login
      render EldritchUi::IconComponent.new(name: "login", size: "lg")
    end

    # @label Sizes - Extra Small
    def size_xs
      render EldritchUi::IconComponent.new(name: "sparkles", size: "xs")
    end

    # @label Sizes - Small
    def size_sm
      render EldritchUi::IconComponent.new(name: "sparkles", size: "sm")
    end

    # @label Sizes - Medium
    def size_md
      render EldritchUi::IconComponent.new(name: "sparkles", size: "md")
    end

    # @label Sizes - Large
    def size_lg
      render EldritchUi::IconComponent.new(name: "sparkles", size: "lg")
    end

    # @label Sizes - Extra Large
    def size_xl
      render EldritchUi::IconComponent.new(name: "sparkles", size: "xl")
    end

    # @label Sizes - 2X Large
    def size_2xl
      render EldritchUi::IconComponent.new(name: "sparkles", size: "2xl")
    end

    # @label Colors - Primary
    def color_primary
      render EldritchUi::IconComponent.new(name: "check-circle", size: "lg", color: "primary")
    end

    # @label Colors - Secondary
    def color_secondary
      render EldritchUi::IconComponent.new(name: "check-circle", size: "lg", color: "secondary")
    end

    # @label Colors - Success
    def color_success
      render EldritchUi::IconComponent.new(name: "check-circle", size: "lg", color: "success")
    end

    # @label Colors - Warning
    def color_warning
      render EldritchUi::IconComponent.new(name: "check-circle", size: "lg", color: "warning")
    end

    # @label Colors - Danger
    def color_danger
      render EldritchUi::IconComponent.new(name: "check-circle", size: "lg", color: "danger")
    end

    # @label Colors - Muted
    def color_muted
      render EldritchUi::IconComponent.new(name: "check-circle", size: "lg", color: "muted")
    end

    # @label With Custom Classes
    def with_custom_classes
      render EldritchUi::IconComponent.new(
        name: "sparkles",
        size: "lg",
        class: "text-purple-500 animate-pulse"
      )
    end

    # @label Accessibility - Decorative (Default)
    def accessibility_decorative
      render EldritchUi::IconComponent.new(name: "sparkles", size: "sm")
    end

    # @label Accessibility - Semantic
    def accessibility_semantic
      render EldritchUi::IconComponent.new(
        name: "check-circle", 
        size: "sm", 
        color: "success", 
        aria_hidden: false, 
        "aria-label": "Success"
      )
    end

    # @label Unknown Icon (Fallback)
    def unknown_icon
      render EldritchUi::IconComponent.new(name: "unknown-icon")
    end
  end
end