module EldritchUi
  class AssignStudentsFormComponent < ViewComponent::Base
    def initialize(
      assignment:,
      students:,
      selected_ids: [],
      form_url:,
      cancel_url: nil,
      show_note: true,
      **html_attributes
    )
      @assignment = assignment
      @students = students || []
      @selected_ids = selected_ids || []
      @form_url = form_url
      @cancel_url = cancel_url
      @show_note = show_note
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :assignment, :students, :selected_ids, :form_url, :cancel_url, :show_note

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?
      attrs
    end

    def default_css_classes
      "eld-assign-students-form"
    end

    def has_students?
      students.any?
    end

    def students_count
      students.size
    end

    def selected_count
      selected_ids.size
    end

    def form_controller_attributes
      {
        controller: "eldritch-ui--assign-students",
        "eldritch-ui--assign-students-processing-value": assignment_in_progress?,
        action: "submit->eldritch-ui--assign-students#submitForm"
      }
    end

    def assignment_in_progress?
      assignment&.status == "in_progress"
    end

    def student_has_started?(student)
      return false unless assignment&.respond_to?(:student_has_started?)
      assignment.student_has_started?(student.id)
    end

    def student_progress(student)
      return nil unless assignment&.respond_to?(:student_progress)
      assignment.student_progress(student)
    end

    def student_is_selected?(student)
      selected_ids.include?(student.id)
    end

    def student_is_disabled?(student)
      assignment_in_progress? || student_has_started?(student)
    end

    def student_name(student)
      return "Unknown Student" unless student
      if student.respond_to?(:name)
        student.name
      elsif student.respond_to?(:first_name) && student.respond_to?(:last_name)
        "#{student.first_name} #{student.last_name}".strip
      else
        "Student ##{student.id}"
      end
    end

    def student_email(student)
      return "" unless student
      student.respond_to?(:email_address) ? student.email_address : ""
    end

    def progress_status_class(status)
      case status.to_s.downcase
      when "completed"
        "eld-assign-students-form__status-badge--completed"
      when "in_progress"
        "eld-assign-students-form__status-badge--in-progress"
      else
        "eld-assign-students-form__status-badge--not-started"
      end
    end

    def progress_percentage(progress)
      return 0 unless progress && progress[:total_questions].to_i > 0
      (progress[:answered_questions].to_f / progress[:total_questions] * 100).round
    end

    def show_warning_note?
      show_note && assignment_in_progress?
    end

    def cancel_button_url
      cancel_url || "#"
    end
  end
end
