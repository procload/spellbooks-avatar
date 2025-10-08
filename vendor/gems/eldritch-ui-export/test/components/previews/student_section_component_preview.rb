class EldritchUi::StudentSectionComponentPreview < ViewComponent::Preview
  # @label Default Student Section
  # @display min_height 300px
  def default
    render EldritchUi::StudentSectionComponent.new(
      student: sample_student,
      assignments: sample_assignments
    )
  end

  # @label Student with No Assignments
  # @display min_height 250px
  def empty_assignments
    render EldritchUi::StudentSectionComponent.new(
      student: sample_student
    )
  end

  # @label Student with Many Assignments
  # @display min_height 500px
  def many_assignments
    render EldritchUi::StudentSectionComponent.new(
      student: sample_student,
      assignments: many_sample_assignments
    )
  end

  # @label Student with Long Name
  # @display min_height 300px
  def long_name
    render EldritchUi::StudentSectionComponent.new(
      student: student_with_long_name,
      assignments: sample_assignments
    )
  end

  # @label Student with Long Email
  # @display min_height 300px
  def long_email
    render EldritchUi::StudentSectionComponent.new(
      student: student_with_long_email,
      assignments: sample_assignments
    )
  end

  # @label Various Progress States
  # @display min_height 600px
  def progress_states
    render EldritchUi::StudentSectionComponent.new(
      student: sample_student,
      assignments: progress_variations
    )
  end

  # @label Student without Email
  # @display min_height 300px
  def no_email
    render EldritchUi::StudentSectionComponent.new(
      student: student_without_email,
      assignments: sample_assignments
    )
  end

  # @label Custom CSS Classes
  # @display min_height 300px
  def custom_classes
    render EldritchUi::StudentSectionComponent.new(
      student: sample_student,
      assignments: sample_assignments,
      class: "border-2 border-blue-500 bg-blue-50"
    )
  end

  # @label With Data Attributes
  # @display min_height 300px
  def with_data_attributes
    render EldritchUi::StudentSectionComponent.new(
      student: sample_student,
      assignments: sample_assignments,
      id: "student-section-example",
      data: { testid: "student-section", student_id: "456" }
    )
  end

  # @label Mobile Layout Test
  # @display min_height 400px
  # @display max_width 375px
  def mobile_layout
    render EldritchUi::StudentSectionComponent.new(
      student: sample_student,
      assignments: sample_assignments
    )
  end

  # @label Different Assignment Types
  # @display min_height 500px
  def varied_assignment_types
    render EldritchUi::StudentSectionComponent.new(
      student: sample_student,
      assignments: varied_assignments
    )
  end

  # @label Edge Case - Minimal Data
  # @display min_height 200px
  def minimal_data
    render EldritchUi::StudentSectionComponent.new(
      student: minimal_student
    )
  end

  # @label Compact Content View
  # @display min_height 250px
  def compact_view
    render EldritchUi::StudentSectionComponent.new(
      student: sample_student,
      assignments: sample_assignments.take(1),
      class: "max-w-md"
    )
  end

  # @label Print Preview
  # @display min_height 350px
  def print_preview
    render EldritchUi::StudentSectionComponent.new(
      student: sample_student,
      assignments: sample_assignments,
      class: "print-preview"
    )
  end

  private

  def sample_student
    @sample_student ||= User.new(
      id: 1,
      first_name: "David",
      last_name: "Wilson", 
      email_address: "david.wilson@school.edu",
      role: "student"
    ).tap { |u| u.id = 1 } # Simulate persisted
  end

  def student_with_long_name
    @student_long_name ||= User.new(
      id: 2,
      first_name: "Christopher Alexander",
      last_name: "Wellington-Montgomery IV",
      email_address: "christopher.wellington@prestigious.academy.edu",
      role: "student"
    ).tap { |u| u.id = 2 }
  end

  def student_with_long_email
    @student_long_email ||= User.new(
      id: 3,
      first_name: "Maria",
      last_name: "Rodriguez",
      email_address: "maria.rodriguez.international.exchange@verylongschoolnameuniversity.education.gov",
      role: "student"
    ).tap { |u| u.id = 3 }
  end

  def student_without_email
    @student_no_email ||= User.new(
      id: 4,
      first_name: "Emma",
      last_name: "Thompson",
      email_address: nil,
      role: "student"
    ).tap { |u| u.id = 4 }
  end

  def minimal_student
    @minimal_student ||= User.new(
      id: 5,
      first_name: "A",
      last_name: "B",
      email_address: "ab@school.edu",
      role: "student"
    ).tap { |u| u.id = 5 }
  end

  def sample_assignments
    @sample_assignments ||= [
      {
        assignment: Assignment.new(
          id: 1,
          title: "Geography Quiz",
          subject: "Social Studies",
          grade_level: 7,
          difficulty: "Medium",
          number_of_questions: 12,
          interests: "world geography, capitals"
        ),
        progress: 85
      },
      {
        assignment: Assignment.new(
          id: 2,
          title: "Chemistry Basics",
          subject: "Science",
          grade_level: 7,
          difficulty: "Easy", 
          number_of_questions: 8,
          interests: "chemistry, elements"
        ),
        progress: 30
      }
    ]
  end

  def many_sample_assignments
    @many_assignments ||= (1..8).map do |i|
      {
        assignment: Assignment.new(
          id: i,
          title: "Assignment #{i}",
          subject: ["Mathematics", "Science", "English", "History", "Art"].sample,
          grade_level: 7,
          difficulty: ["Easy", "Medium", "Hard"].sample,
          number_of_questions: [5, 10, 15, 20].sample,
          interests: "sample interests"
        ),
        progress: [0, 20, 40, 60, 80, 100].sample
      }
    end
  end

  def progress_variations
    @progress_variations ||= [
      {
        assignment: Assignment.new(
          id: 1,
          title: "Incomplete Assignment",
          subject: "Mathematics",
          grade_level: 7,
          difficulty: "Easy",
          number_of_questions: 10,
          interests: "basic math"
        ),
        progress: 15
      },
      {
        assignment: Assignment.new(
          id: 2,
          title: "Half Done Assignment",
          subject: "English",
          grade_level: 7,
          difficulty: "Medium",
          number_of_questions: 12,
          interests: "reading comprehension"
        ),
        progress: 50
      },
      {
        assignment: Assignment.new(
          id: 3,
          title: "Almost Complete Assignment",
          subject: "Science",
          grade_level: 7,
          difficulty: "Medium",
          number_of_questions: 15,
          interests: "biology, plants"
        ),
        progress: 92
      },
      {
        assignment: Assignment.new(
          id: 4,
          title: "Perfect Score Assignment",
          subject: "History",
          grade_level: 7,
          difficulty: "Hard",
          number_of_questions: 18,
          interests: "world history"
        ),
        progress: 100
      }
    ]
  end

  def varied_assignments
    @varied_assignments ||= [
      {
        assignment: Assignment.new(
          id: 1,
          title: "Quick Quiz",
          subject: "Mathematics",
          grade_level: 7,
          difficulty: "Easy",
          number_of_questions: 3,
          interests: "arithmetic"
        ),
        progress: 100
      },
      {
        assignment: Assignment.new(
          id: 2,
          title: "Comprehensive Literature Analysis Assignment with Extra Long Title",
          subject: "English Literature",
          grade_level: 7,
          difficulty: "Hard",
          number_of_questions: 30,
          interests: "literature analysis, creative writing, poetry interpretation"
        ),
        progress: 45
      },
      {
        assignment: Assignment.new(
          id: 3,
          title: "Special Characters Test: #@$%^&*()",
          subject: "Computer Science",
          grade_level: 7,
          difficulty: "Medium",
          number_of_questions: 10,
          interests: "programming, syntax"
        ),
        progress: 75
      }
    ]
  end
end 