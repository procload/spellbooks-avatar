class EldritchUi::HandDrawnBorderComponentPreview < ViewComponent::Preview
  # @label Default Border
  def default
    render EldritchUi::HandDrawnBorderComponent.new do
      tag.p "This is content with a default hand-drawn border.", style: "margin: 0; padding: 1rem;"
    end
  end

  # @label Color Variations
  def color_variations
    content_tag :div, style: "display: grid; gap: 1rem; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));" do
      safe_join([
        render(EldritchUi::HandDrawnBorderComponent.new(color: :brown)) do
          tag.p "Brown border (default)", style: "margin: 0; padding: 1rem;"
        end,
        render(EldritchUi::HandDrawnBorderComponent.new(color: :gold)) do
          tag.p "Gold border", style: "margin: 0; padding: 1rem;"
        end,
        render(EldritchUi::HandDrawnBorderComponent.new(color: :blue)) do
          tag.p "Blue border", style: "margin: 0; padding: 1rem;"
        end,
        render(EldritchUi::HandDrawnBorderComponent.new(color: :red)) do
          tag.p "Red border", style: "margin: 0; padding: 1rem;"
        end
      ])
    end
  end

  # @label Thickness Options
  def thickness_options
    content_tag :div, style: "display: grid; gap: 1rem; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));" do
      safe_join([
        render(EldritchUi::HandDrawnBorderComponent.new(thickness: :thin)) do
          tag.p "Thin border", style: "margin: 0; padding: 1rem;"
        end,
        render(EldritchUi::HandDrawnBorderComponent.new(thickness: :default)) do
          tag.p "Default thickness", style: "margin: 0; padding: 1rem;"
        end,
        render(EldritchUi::HandDrawnBorderComponent.new(thickness: :thick)) do
          tag.p "Thick border", style: "margin: 0; padding: 1rem;"
        end
      ])
    end
  end

  # @label Implementation Methods
  def implementation_methods
    content_tag :div, style: "display: grid; gap: 1rem; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));" do
      safe_join([
        render(EldritchUi::HandDrawnBorderComponent.new(method: :border_image)) do
          tag.p "Border-image method (default)", style: "margin: 0; padding: 1rem;"
        end,
        render(EldritchUi::HandDrawnBorderComponent.new(method: :background)) do
          tag.p "Background method", style: "margin: 0; padding: 1rem;"
        end
      ])
    end
  end

  # @label Custom Colors
  def custom_colors
    content_tag :div, style: "display: grid; gap: 1rem; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));" do
      safe_join([
        render(EldritchUi::HandDrawnBorderComponent.new(color: "#FF5733")) do
          tag.p "Custom orange", style: "margin: 0; padding: 1rem;"
        end,
        render(EldritchUi::HandDrawnBorderComponent.new(color: "#8E44AD")) do
          tag.p "Custom purple", style: "margin: 0; padding: 1rem;"
        end,
        render(EldritchUi::HandDrawnBorderComponent.new(color: "#16A085")) do
          tag.p "Custom teal", style: "margin: 0; padding: 1rem;"
        end
      ])
    end
  end

  # @label Form Example
  def form_example
    render EldritchUi::HandDrawnBorderComponent.new(color: :blue, class: "eld-hand-drawn-border--form-field") do
      safe_join([
        tag.label("Magic Spell Name:", for: "spell-name", style: "display: block; margin-bottom: 0.5rem; font-weight: bold;"),
        tag.input(type: "text", id: "spell-name", placeholder: "Enter spell name...", style: "width: 100%; padding: 0.5rem; border: 1px solid #ccc; border-radius: 4px;")
      ])
    end
  end

  # @label Card Example
  def card_example
    render EldritchUi::HandDrawnBorderComponent.new(color: :gold, class: "eld-hand-drawn-border--card") do
      safe_join([
        tag.h3("Ancient Wisdom", style: "margin: 0 0 1rem 0; color: #8B4513;"),
        tag.p("This mystical card contains ancient knowledge passed down through generations of wizards and scholars.", style: "margin: 0; line-height: 1.5;")
      ])
    end
  end

  # @label Complex Content
  def complex_content
    render EldritchUi::HandDrawnBorderComponent.new(color: :red, thickness: :thick) do
      content_tag :div, style: "padding: 1.5rem;" do
        safe_join([
          tag.h2("Spell Components", style: "margin: 0 0 1rem 0; color: #8B4513;"),
          tag.ul(style: "margin: 0 0 1rem 0; padding-left: 1.5rem;") do
            safe_join([
              tag.li("Dragon scales (3 pieces)"),
              tag.li("Moonstone powder (1 vial)"),
              tag.li("Phoenix feather (optional)")
            ])
          end,
          tag.p("Combine ingredients under the light of a full moon for maximum potency.", style: "margin: 0; font-style: italic;")
        ])
      end
    end
  end

  private

  def safe_join(array)
    array.map(&:html_safe).join.html_safe
  end
end 