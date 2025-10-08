module EldritchUi
  class HandDrawnBorderComponent < ViewComponent::Base
    def initialize(color: :brown, thickness: :default, method: :border_image, **html_attributes)
      @color = color
      @thickness = thickness
      @method = method
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :color, :thickness, :method

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?

      # Add custom CSS properties for dynamic styling
      style_parts = []
      unless valid_color_variants.include?(color.to_sym)
        style_parts << "--eldritch-border-hand-drawn-color: #{color}"
      end

      existing_style = attrs[:style].to_s
      if style_parts.any?
        attrs[:style] = [ existing_style, style_parts.join("; ") ].reject(&:blank?).join("; ")
      end

      attrs
    end

    def default_css_classes
      classes = [ "eld-hand-drawn-border" ]

      # Add color class only if it's a valid variant
      if valid_color_variants.include?(color.to_sym)
        classes << "eld-hand-drawn-border--#{color}"
      end

      # Add thickness class
      classes << "eld-hand-drawn-border--#{thickness}" unless thickness == :default

      # Add method class
      classes << "eld-hand-drawn-border--#{method}" unless method == :border_image

      classes.join(" ")
    end

    def valid_color_variants
      [ :brown, :gold, :blue, :red ]
    end
  end
end
