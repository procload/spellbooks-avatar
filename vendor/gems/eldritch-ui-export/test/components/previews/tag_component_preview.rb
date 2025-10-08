# frozen_string_literal: true

# Lookbook previews for EldritchUi::TagComponent
class EldritchUi::TagComponentPreview < ViewComponent::Preview
  # 🎉 Tag playground! 🎉
  # -----------------------
  # You can use the controls in the 'Params' section
  # to set tag property values on the fly.
  #
  # @param text "Tag text content"
  # @param interactive [Boolean] toggle "Is the tag interactive?"
  # @param dismissible [Boolean] toggle "Is the tag dismissible?"
  # @param selected [Boolean] toggle "Is the tag selected?"
  # @param disabled [Boolean] toggle "Is the tag disabled?"
  # @param value "Optional value for form submission"
  # @param href "Optional URL for link behavior"
  def playground(text: "Sample Tag", interactive: false, dismissible: false, selected: false, disabled: false, value: "", href: "")
    render EldritchUi::TagComponent.new(
      text: text,
      interactive: interactive,
      dismissible: dismissible,
      selected: selected,
      disabled: disabled,
      value: value.present? ? value : nil,
      href: href.present? ? href : nil
    )
  end

  # Default tag (non-dismissible)
  # @!group Basic Examples
  def default
    render EldritchUi::TagComponent.new(text: "Default Tag")
  end

  # Dismissible tag with close button
  # @!group Dismissible Examples
  def dismissible_tag
    render EldritchUi::TagComponent.new(
      text: "Dismissible Tag",
      dismissible: true,
      value: "tag-value"
    )
  end

  # Tag rendered as a link
  # @!group Link Examples
  def tag_link
    render EldritchUi::TagComponent.new(
      text: "Tag Link",
      href: "/tag/example"
    )
  end

  def dismissible_tag_link
    render EldritchUi::TagComponent.new(
      text: "Dismissible Link",
      href: "/tag/dismissible",
      dismissible: true,
      value: "link-tag"
    )
  end

  # Tags with custom content using slots
  # @!group Advanced
  def with_icon_content
    render EldritchUi::TagComponent.new(dismissible: true, value: "icon-tag") do
      "📚 Book Tag".html_safe
    end
  end

  def with_count
    render EldritchUi::TagComponent.new(dismissible: true, value: "count-tag") do
      "Items <span class='font-bold text-xs'>(3)</span>".html_safe
    end
  end

  # Common tag usage patterns
  # @!group Usage Patterns
  def skill_tags
    render EldritchUi::TagComponent.new(
      text: "JavaScript",
      dismissible: true,
      value: "javascript"
    )
  end

  def category_tags
    render EldritchUi::TagComponent.new(
      text: "Frontend",
      dismissible: true,
      value: "frontend",
      data: { category: "blue" }
    )
  end

  # Form input tags (like token input)
  # @!group Form Examples
  def form_tags_example
    render EldritchUi::TagComponent.new(
      text: "React",
      dismissible: true,
      value: "react",
      data: { 
        action: "eldritch-ui:tag:dismiss->form#removeTag",
        tech_id: "react" 
      }
    )
  end

  # Status and state tags
  # @!group Status Examples
  def status_tags
    render EldritchUi::TagComponent.new(
      text: "Published",
      dismissible: false,
      value: "published"
    )
  end

  # User assignment tags
  # @!group User Examples
  def user_tags
    render EldritchUi::TagComponent.new(
      text: "Alice Johnson",
      dismissible: true,
      value: "alice-johnson",
      title: "Click × to remove Alice Johnson"
    )
  end

  # Interactive dismiss example
  # @!group Interactive
  def dismissible_example
    render EldritchUi::TagComponent.new(
      text: "Removable",
      dismissible: true,
      value: "tag-0",
      data: { 
        action: "eldritch-ui:tag:dismiss->demo#handleTagDismiss",
        tag_id: "tag-0"
      }
    )
  end

  # Mixed dismissible and non-dismissible
  # @!group Mixed Examples
  def mixed_permissions
    render EldritchUi::TagComponent.new(
      text: "Admin",
      dismissible: false,
      value: "admin",
      title: "Admin tag cannot be removed"
    )
  end
end