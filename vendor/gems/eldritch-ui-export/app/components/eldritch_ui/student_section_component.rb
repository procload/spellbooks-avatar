module EldritchUi
  class StudentSectionComponent < ViewComponent::Base
    def initialize(student:, assignments: [], **html_attributes)
      @student = student
      @assignments = assignments || []
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :student, :assignments

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?
      attrs
    end

    def default_css_classes
      "eld-student-section"
    end

    def student_name
      return "" unless student
      "#{student.first_name} #{student.last_name}".strip
    end

    def student_email
      student&.email_address
    end

    def has_assignments?
      assignments.any?
    end

    def assignments_count
      assignments.size
    end
  end
end
