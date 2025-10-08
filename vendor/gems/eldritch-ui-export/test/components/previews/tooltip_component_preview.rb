# frozen_string_literal: true

# Lookbook previews for EldritchUi::TooltipComponent
class EldritchUi::TooltipComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param text "Tooltip text"
  # @param position select "Position" :position_options
  # @param size select "Size" :size_options
  # @param delay number "Delay (ms)"
  def playground(text: "Helpful info appears here", position: :top, size: :medium, delay: 300)
    render EldritchUi::TooltipComponent.new(text: text, position: position, size: size, delay: delay)
  end

  # @!group Positions
  def top
    render EldritchUi::TooltipComponent.new(text: "Top tooltip", position: :top)
  end

  def bottom
    render EldritchUi::TooltipComponent.new(text: "Bottom tooltip", position: :bottom)
  end

  def left
    render EldritchUi::TooltipComponent.new(text: "Left tooltip", position: :left)
  end

  def right
    render EldritchUi::TooltipComponent.new(text: "Right tooltip", position: :right)
  end

  # @!group Sizes
  def small
    render EldritchUi::TooltipComponent.new(text: "Small tooltip", size: :small)
  end

  def large
    render EldritchUi::TooltipComponent.new(text: "Large tooltip", size: :large)
  end

  # @!group Custom Trigger
  def with_custom_trigger
    render EldritchUi::TooltipComponent.new(text: "Custom trigger tooltip") do
      "<button class='eld-btn'>Hover me</button>".html_safe
    end
  end

  private

  def position_options
    %i[top bottom left right]
  end

  def size_options
    %i[small medium large]
  end
end

