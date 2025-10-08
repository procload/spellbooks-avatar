module EldritchUi
  class SidebarComponent < ViewComponent::Base
    def initialize(**html_attributes)
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :html_attributes

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?
      attrs
    end

    def default_css_classes
      "eld-sidebar"
    end

    def current_user
      Current.user
    end

    def show_create_assignment_link?
      current_user&.teacher? || current_user&.admin?
    end

    def show_students_link?
      current_user&.teacher? || current_user&.admin?
    end

    def current_controller_is?(controller_name)
      helpers.controller_name == controller_name
    end

    def action_name
      helpers.action_name
    end
  end
end
