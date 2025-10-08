# frozen_string_literal: true

module EldritchUi
  class TooltipComponent < ViewComponent::Base
    def initialize(
      text:,
      trigger_content: nil,
      position: :top,
      size: :medium,
      delay: 300,
      **html_attributes
    )
      @text = text
      @trigger_content = trigger_content
      @position = position.to_s
      @size = size.to_s
      @delay = delay
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :text, :trigger_content, :position, :size, :delay, :html_attributes

    def tooltip_id
      @tooltip_id ||= "tooltip-#{SecureRandom.hex(4)}"
    end

    def trigger_id
      @trigger_id ||= "#{tooltip_id}-trigger"
    end

    def tooltip_attributes
      base_attrs = {
        id: tooltip_id,
        role: "tooltip",
        "aria-hidden": "true"
      }

      attrs = html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split

      attrs.merge!(base_attrs)
      attrs[:class] = (default_tooltip_classes.split + custom_classes).uniq.join(" ")

      attrs.compact
    end

    def trigger_attributes
      {
        id: trigger_id,
        "aria-describedby": tooltip_id,
        "data-controller": "tooltip",
        "data-tooltip-delay-value": delay,
        "data-tooltip-position-value": position
      }
    end

    def default_tooltip_classes
      classes = [ "eld-tooltip" ]
      classes << "eld-tooltip--#{position}" if %w[top bottom left right].include?(position)
      classes << "eld-tooltip--#{size}" if %w[small medium large].include?(size)
      classes.join(" ")
    end

    def default_trigger_classes
      "eld-tooltip-trigger"
    end

    def has_custom_trigger?
      trigger_content.present?
    end

    def default_trigger_icon
      "question-mark-circle"
    end
  end
end
