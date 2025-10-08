module EldritchUi
  class AssignmentImageComponent < ViewComponent::Base
    def initialize(assignment:, show_regenerate_button: false, **html_attributes)
      @assignment = assignment
      @show_regenerate_button = show_regenerate_button
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :assignment, :show_regenerate_button

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?
      attrs
    end

    def default_css_classes
      "eld-assignment-image"
    end

    def image_status
      assignment.image_status
    end

    def image_status_message
      assignment.image_status_message
    end

    def show_error_alert?
      image_status == "error"
    end

    def show_regenerate_button?
      show_regenerate_button && assignment.can_regenerate_image?
    end

    def image_variant
      assignment.cached_image_variant if assignment.image.attached?
    end

    def placeholder_image_path
      "placeholder.png"
    end

    def error_type_icon
      case assignment.image_generation_error&.downcase
      when /timeout/
        "clock"
      when /inappropriate|violation|policy/
        "shield-alert"
      when /quota|limit/
        "gauge"
      when /authentication/
        "key"
      when /service|unavailable/
        "wifi-off"
      else
        "alert-circle"
      end
    end
  end
end
