# frozen_string_literal: true

# Lookbook previews for EldritchUi::PillComponent
class EldritchUi::PillComponentPreview < ViewComponent::Preview
  # 🎉 Pill playground! 🎉
  # -----------------------
  # You can use the controls in the 'Params' section
  # to set pill property values on the fly.
  #
  # @param text "Pill text content"
  # @param interactive [Boolean] toggle "Is the pill interactive?"
  # @param selected [Boolean] toggle "Is the pill selected?"
  # @param size select "Size of the pill" :size_options
  # @param value "Optional value for form submission"
  # @param href "Optional URL for link behavior"
  def playground(text: "Sample Pill", interactive: false, selected: false, size: :default, value: "", href: "")
    render EldritchUi::PillComponent.new(
      text: text,
      interactive: interactive,
      selected: selected,
      size: size,
      value: value.present? ? value : nil,
      href: href.present? ? href : nil
    )
  end

  # Default pill (non-interactive)
  # @!group Basic Examples
  def default
    render EldritchUi::PillComponent.new(text: "Default Pill")
  end

  # Interactive pill that can be toggled/selected
  # @!group Interactive Examples
  def interactive_pill
    render EldritchUi::PillComponent.new(
      text: "Interactive Pill",
      interactive: true,
      value: "filter-value"
    )
  end

  def selected_pill
    render EldritchUi::PillComponent.new(
      text: "Selected Pill",
      interactive: true,
      selected: true,
      value: "selected-value"
    )
  end

  # Size variants showcase
  # @!group Sizes
  def small_pill
    render EldritchUi::PillComponent.new(
      text: "Small Pill",
      size: :small,
      interactive: true
    )
  end

  def default_pill
    render EldritchUi::PillComponent.new(
      text: "Default Pill",
      size: :default,
      interactive: true
    )
  end

  def large_pill
    render EldritchUi::PillComponent.new(
      text: "Large Pill",
      size: :large,
      interactive: true
    )
  end

  # Pill rendered as a link
  # @!group Link Examples
  def pill_link
    render EldritchUi::PillComponent.new(
      text: "Pill Link",
      href: "/example"
    )
  end

  def interactive_pill_link
    render EldritchUi::PillComponent.new(
      text: "Interactive Link",
      href: "/filter",
      interactive: true,
      value: "link-filter"
    )
  end

  # Pills with custom content using slots
  # @!group Advanced
  def with_icon_content
    render EldritchUi::PillComponent.new(interactive: true, value: "icon-pill") do
      "🏷️ Icon Pill".html_safe
    end
  end

  def with_count
    render EldritchUi::PillComponent.new(interactive: true, value: "count-pill") do
      "Category <span class='font-bold'>5</span>".html_safe
    end
  end

  # Filter pill examples (common use case)
  # @!group Filter Examples
  def filter_pills_example
    render(EldritchUi::PillComponent.new(
      text: "All",
      interactive: true,
      selected: true,
      value: "all"
    ))
  end

  # Navigation pills
  # @!group Navigation Examples
  def navigation_pills
    render(EldritchUi::PillComponent.new(
      text: "Overview",
      href: "/overview",
      interactive: true
    ))
  end

  # Tag-like usage (showing pill as a base for tags)
  # @!group Tag-like Usage
  def tag_like_usage
    render(EldritchUi::PillComponent.new(
      text: "JavaScript",
      value: "javascript"
    ))
  end

  # Interactive example with JavaScript
  # @!group Interactive
  def interactive_example
    render(EldritchUi::PillComponent.new(
      text: "Frontend",
      interactive: true,
      value: "frontend",
      data: { 
        action: "click->demo#handlePillClick",
        category: "frontend"
      }
    ))
  end

  private

  def size_options
    [:small, :default, :large]
  end
end