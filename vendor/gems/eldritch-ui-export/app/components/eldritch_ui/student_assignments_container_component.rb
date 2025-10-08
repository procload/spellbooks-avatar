module EldritchUi
  class StudentAssignmentsContainerComponent < ViewComponent::Base
    def initialize(students:, assignments_by_student: {}, show_empty_message: true, **html_attributes)
      @students = students || []
      @assignments_by_student = assignments_by_student || {}
      @show_empty_message = show_empty_message
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :students, :assignments_by_student, :show_empty_message

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?
      attrs
    end

    def default_css_classes
      "eld-student-assignments-container"
    end

    def has_students?
      students.any?
    end

    def students_count
      students.size
    end

    def assignments_for_student(student)
      return [] unless student&.id
      assignments_by_student[student.id] || []
    end

    def total_assignments_count
      assignments_by_student.values.flatten.size
    end

    def show_empty_message?
      show_empty_message && !has_students?
    end
  end
end
