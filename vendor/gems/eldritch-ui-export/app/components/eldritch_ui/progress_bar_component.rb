# frozen_string_literal: true

module EldritchUi
  class ProgressBarComponent < ViewComponent::Base
    def initialize(value:, max: 100, label: nil, size: :medium, **html_attributes)
      @value = value.to_f
      @max = max.to_f
      @label = label
      @size = size.to_sym
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :value, :max, :label, :size

    def progress_percentage
      return 0 if max <= 0

      normalized_value = [ [ 0, value ].max, max ].min
      percentage = (normalized_value / max * 100).round(2)

      # Convert to integer if it's a whole number, otherwise keep decimal
      percentage == percentage.to_i ? percentage.to_i : percentage
    end

    def bar_width_style
      "width: #{progress_percentage}%"
    end

    def component_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")

      attrs[:class] = final_classes if final_classes.present?
      attrs
    end

    def progress_bar_attributes
      {
        class: progress_bar_css_classes,
        style: bar_width_style,
        role: "progressbar",
        "aria-valuenow" => progress_percentage.to_s,
        "aria-valuemin" => "0",
        "aria-valuemax" => "100"
      }.tap do |attrs|
        attrs["aria-label"] = label if label.present?
      end
    end

    def default_css_classes
      classes = [ "eld-progress-bar" ]
      classes << "eld-progress-bar--#{size}" if size != :medium
      classes.join(" ")
    end

    def progress_bar_css_classes
      "eld-progress-bar__fill"
    end
  end
end
