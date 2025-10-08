module EldritchUi
  class LoadingOverlayComponent < ViewComponent::Base
    def initialize(message: nil, visible: false, full_screen: true, **html_attributes)
      @message = message
      @visible = visible
      @full_screen = full_screen
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :message, :visible, :full_screen

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?

      # Add Stimulus controller and data attributes
      attrs["data-controller"] = "eldritch-ui--loading-overlay"
      attrs["data-eldritch-ui--loading-overlay-visible-value"] = visible
      attrs["data-eldritch-ui--loading-overlay-target"] = "overlay"

      attrs
    end

    def default_css_classes
      classes = [ "eld-loading-overlay" ]
      classes << "eld-loading-overlay--visible" if visible?
      classes << "eld-loading-overlay--full-screen" if full_screen?
      classes << "eld-loading-overlay--container" unless full_screen?
      classes.join(" ")
    end

    def spinner_classes
      "eld-loading-overlay__spinner"
    end

    def content_classes
      "eld-loading-overlay__content"
    end

    def message_classes
      "eld-loading-overlay__message"
    end

    def visible?
      @visible
    end

    def full_screen?
      @full_screen
    end

    def has_message?
      message.present?
    end
  end
end
