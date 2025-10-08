class EldritchUi::AssignStudentsFormComponentPreview < ViewComponent::Preview
  # Default form with multiple students
  def default
    assignment = create_assignment("Mathematics Quiz", "draft")
    students = create_students(5)
    selected_ids = [students[0].id, students[2].id]
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: selected_ids,
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Form with in-progress assignment (shows warning)
  def in_progress_assignment
    assignment = create_assignment("Science Test", "in_progress")
    students = create_students(4)
    selected_ids = [students[0].id, students[1].id]
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: selected_ids,
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Form with no students available
  def no_students_available
    assignment = create_assignment("Empty Assignment", "draft")
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: [],
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Form with students that have progress
  def students_with_progress
    assignment = create_assignment("Reading Comprehension", "in_progress")
    students = create_students_with_progress()
    selected_ids = students.map(&:id)
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: selected_ids,
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Form with all students selected
  def all_students_selected
    assignment = create_assignment("History Quiz", "draft")
    students = create_students(6)
    selected_ids = students.map(&:id)
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: selected_ids,
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Form with no students selected
  def no_students_selected
    assignment = create_assignment("Art Project", "draft")
    students = create_students(4)
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: [],
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Form with students without email addresses
  def students_without_emails
    assignment = create_assignment("Physical Education", "draft")
    students = [
      OpenStruct.new(id: 1, first_name: "No", last_name: "Email", email_address: nil),
      OpenStruct.new(id: 2, first_name: "Empty", last_name: "Email", email_address: ""),
      OpenStruct.new(id: 3, first_name: "Valid", last_name: "Email", email_address: "valid@example.com")
    ]
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Form with students with long names and emails
  def long_names_and_emails
    assignment = create_assignment("Advanced Literature", "draft")
    students = [
      OpenStruct.new(
        id: 1,
        first_name: "Alexandrina Josephine",
        last_name: "Worthington-Smythe-Richardson",
        email_address: "alexandrina.josephine.worthington-smythe-richardson@verylongschooldistrictname.university.edu"
      ),
      OpenStruct.new(
        id: 2,
        first_name: "Christopher",
        last_name: "Van Der Berg-Williams",
        email_address: "christopher.vandeberg.williams@school.example.edu"
      ),
      OpenStruct.new(
        id: 3,
        first_name: "Short",
        last_name: "Name",
        email_address: "s@x.co"
      )
    ]
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: [1],
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Form with many students (stress test)
  def many_students
    assignment = create_assignment("Large Class Assignment", "draft")
    students = create_students(25)
    selected_ids = students.first(10).map(&:id)
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: selected_ids,
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Form without warning note
  def no_warning_note
    assignment = create_assignment("No Warning Test", "in_progress")
    students = create_students(3)
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}",
      show_note: false
    )
  end

  # Form with custom CSS classes
  def custom_styling
    assignment = create_assignment("Custom Style Assignment", "draft")
    students = create_students(3)
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: [students[0].id],
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}",
      class: "custom-assign-form",
      style: "border: 2px solid #e5e7eb; border-radius: 8px; padding: 16px;"
    )
  end

  # Form with mixed progress states
  def mixed_progress_states
    assignment = create_assignment("Mixed Progress Assignment", "in_progress")
    students = [
      create_student_with_progress("Completed Student", "completed", 20, 20, 18),
      create_student_with_progress("In Progress Student", "in_progress", 15, 20, 12),
      create_student_with_progress("Just Started", "in_progress", 2, 20, 1),
      create_student_with_progress("Not Started", "not_started", 0, 20, 0)
    ]
    selected_ids = students.map(&:id)
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: selected_ids,
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Mobile layout preview (narrow container)
  def mobile_layout
    assignment = create_assignment("Mobile Assignment", "draft")
    students = create_students(4)
    selected_ids = [students[0].id, students[1].id]
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: selected_ids,
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}",
      style: "max-width: 375px; margin: 0 auto;"
    )
  end

  # Form with special character names
  def special_character_names
    assignment = create_assignment("International Students", "draft")
    students = [
      OpenStruct.new(id: 1, first_name: "José María", last_name: "González", email_address: "jose.gonzalez@example.com"),
      OpenStruct.new(id: 2, first_name: "李", last_name: "小明", email_address: "li.xiaoming@example.com"),
      OpenStruct.new(id: 3, first_name: "François", last_name: "Müller", email_address: "francois.muller@example.com"),
      OpenStruct.new(id: 4, first_name: "Олексій", last_name: "Петренко", email_address: "oleksiy.petrenko@example.com")
    ]
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: [1, 3],
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Form showing different status badge colors
  def status_badge_variations
    assignment = create_assignment("Status Variations", "in_progress")
    students = [
      create_student_with_progress("Perfect Score", "completed", 10, 10, 10),
      create_student_with_progress("Almost Done", "in_progress", 9, 10, 8),
      create_student_with_progress("Halfway", "in_progress", 5, 10, 3),
      create_student_with_progress("Just Started", "in_progress", 1, 10, 0),
      create_student_with_progress("Not Started", "not_started", 0, 10, 0)
    ]
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: students,
      selected_ids: students.map(&:id),
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  # Single student form
  def single_student
    assignment = create_assignment("One-on-One Assignment", "draft")
    student = create_students(1).first
    
    render EldritchUi::AssignStudentsFormComponent.new(
      assignment: assignment,
      students: [student],
      selected_ids: [student.id],
      form_url: "/assignments/#{assignment.id}/assign_students",
      cancel_url: "/assignments/#{assignment.id}"
    )
  end

  private

  def create_assignment(title, status)
    MockAssignment.new(
      id: rand(100..999),
      title: title,
      status: status
    )
  end

  # Mock assignment class to avoid OpenStruct issues with method names containing ?
  class MockAssignment
    attr_accessor :id, :title, :status

    def initialize(id:, title:, status:)
      @id = id
      @title = title
      @status = status
    end

    def student_has_started?(student_id)
      @status == "in_progress" && [1, 2].include?(student_id)
    end

    def student_progress(student)
      return nil unless @status == "in_progress"
      
      case student.id
      when 1
        { status: "completed", answered_questions: 10, total_questions: 10, correct_answers: 9 }
      when 2
        { status: "in_progress", answered_questions: 7, total_questions: 10, correct_answers: 5 }
      when 3
        { status: "in_progress", answered_questions: 3, total_questions: 10, correct_answers: 2 }
      else
        { status: "not_started", answered_questions: 0, total_questions: 10, correct_answers: 0 }
      end
    end
  end

  def create_students(count)
    (1..count).map do |i|
      OpenStruct.new(
        id: i,
        first_name: "Student",
        last_name: "#{i.to_s.rjust(2, '0')}",
        email_address: "student#{i}@example.com"
      )
    end
  end

  def create_students_with_progress
    [
      create_student_with_progress("Completed Student", "completed", 15, 15, 14),
      create_student_with_progress("In Progress Student", "in_progress", 10, 15, 8),
      create_student_with_progress("Just Started", "in_progress", 2, 15, 1),
      create_student_with_progress("Not Started", "not_started", 0, 15, 0)
    ]
  end

  def create_student_with_progress(name, status, answered, total, correct)
    parts = name.split(" ")
    student = OpenStruct.new(
      id: rand(1000..9999),
      first_name: parts[0...-1].join(" "),
      last_name: parts.last,
      email_address: "#{name.downcase.gsub(/\s+/, '.')}@example.com"
    )
    
    # Add progress method using define_singleton_method
    progress_data = {
      status: status,
      answered_questions: answered,
      total_questions: total,
      correct_answers: correct
    }
    
    student.define_singleton_method(:progress) do
      progress_data
    end
    
    student.define_singleton_method(:progress=) do |value|
      progress_data = value
    end
    
    student
  end
end 