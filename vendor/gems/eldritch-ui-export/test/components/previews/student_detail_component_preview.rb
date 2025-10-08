class EldritchUi::StudentDetailComponentPreview < ViewComponent::Preview
  # @label Default Student Detail
  # @display min_height 300px
  def default
    render EldritchUi::StudentDetailComponent.new(
      student: sample_student,
      assignments: sample_assignments
    )
  end

  # @label Student with No Assignments
  # @display min_height 250px
  def empty_assignments
    render EldritchUi::StudentDetailComponent.new(
      student: sample_student
    )
  end

  # @label Student with Many Assignments
  # @display min_height 500px
  def many_assignments
    render EldritchUi::StudentDetailComponent.new(
      student: sample_student,
      assignments: many_sample_assignments
    )
  end

  # @label Without Edit Link
  # @display min_height 300px
  def no_edit_link
    render EldritchUi::StudentDetailComponent.new(
      student: sample_student,
      assignments: sample_assignments,
      show_edit_link: false
    )
  end

  # @label Student with Long Name
  # @display min_height 300px
  def long_name
    render EldritchUi::StudentDetailComponent.new(
      student: student_with_long_name,
      assignments: sample_assignments
    )
  end

  # @label Student with Long Email
  # @display min_height 300px
  def long_email
    render EldritchUi::StudentDetailComponent.new(
      student: student_with_long_email,
      assignments: sample_assignments
    )
  end

  # @label Various Progress States
  # @display min_height 600px
  def progress_states
    render EldritchUi::StudentDetailComponent.new(
      student: sample_student,
      assignments: progress_variations
    )
  end

  # @label Non-Persisted Student
  # @display min_height 250px
  def non_persisted_student
    render EldritchUi::StudentDetailComponent.new(
      student: non_persisted_student
    )
  end

  # @label Student without Email
  # @display min_height 300px
  def no_email
    render EldritchUi::StudentDetailComponent.new(
      student: student_without_email,
      assignments: sample_assignments
    )
  end

  # @label Custom CSS Classes
  # @display min_height 300px
  def custom_classes
    render EldritchUi::StudentDetailComponent.new(
      student: sample_student,
      assignments: sample_assignments,
      class: "border-2 border-red-500 bg-red-50"
    )
  end

  # @label With Data Attributes
  # @display min_height 300px
  def with_data_attributes
    render EldritchUi::StudentDetailComponent.new(
      student: sample_student,
      assignments: sample_assignments,
      id: "student-detail-example",
      data: { testid: "student-detail", student_id: "123" }
    )
  end

  # @label Mobile Layout Test
  # @display min_height 400px
  # @display max_width 375px
  def mobile_layout
    render EldritchUi::StudentDetailComponent.new(
      student: sample_student,
      assignments: sample_assignments
    )
  end

  # @label Different Assignment Types
  # @display min_height 500px
  def varied_assignment_types
    render EldritchUi::StudentDetailComponent.new(
      student: sample_student,
      assignments: varied_assignments
    )
  end

  # @label Edge Case - Minimal Data
  # @display min_height 200px
  def minimal_data
    render EldritchUi::StudentDetailComponent.new(
      student: minimal_student
    )
  end

  private

  def sample_student
    @sample_student ||= User.new(
      id: 1,
      first_name: "Emily",
      last_name: "Johnson", 
      email_address: "emily.johnson@school.edu",
      role: "student"
    ).tap { |u| u.id = 1 } # Simulate persisted
  end

  def student_with_long_name
    @student_long_name ||= User.new(
      id: 2,
      first_name: "Alexander Maximilian",
      last_name: "Von Habsburg-Lothringen III",
      email_address: "alexander.vonhabsburg@royalacademy.edu",
      role: "student"
    ).tap { |u| u.id = 2 }
  end

  def student_with_long_email
    @student_long_email ||= User.new(
      id: 3,
      first_name: "Sarah",
      last_name: "Wilson",
      email_address: "sarah.wilson.mathematics.department@verylongschoolname.university.edu",
      role: "student"
    ).tap { |u| u.id = 3 }
  end

  def student_without_email
    @student_no_email ||= User.new(
      id: 4,
      first_name: "Michael",
      last_name: "Brown",
      email_address: nil,
      role: "student"
    ).tap { |u| u.id = 4 }
  end

  def non_persisted_student
    @non_persisted ||= User.new(
      first_name: "New",
      last_name: "Student",
      email_address: "new.student@school.edu",
      role: "student"
    )
  end

  def minimal_student
    @minimal_student ||= User.new(
      id: 5,
      first_name: "J",
      last_name: "D",
      email_address: "jd@school.edu",
      role: "student"
    ).tap { |u| u.id = 5 }
  end

  def sample_assignments
    @sample_assignments ||= [
      {
        assignment: Assignment.new(
          id: 1,
          title: "Math Quiz Chapter 5",
          subject: "Mathematics",
          grade_level: 8,
          difficulty: "Medium",
          number_of_questions: 10,
          interests: "algebra, equations"
        ),
        progress: 75
      },
      {
        assignment: Assignment.new(
          id: 2,
          title: "Science Lab Report",
          subject: "Science",
          grade_level: 8,
          difficulty: "Hard", 
          number_of_questions: 15,
          interests: "chemistry, experiments"
        ),
        progress: 45
      }
    ]
  end

  def many_sample_assignments
    @many_assignments ||= (1..6).map do |i|
      {
        assignment: Assignment.new(
          id: i,
          title: "Assignment #{i}",
          subject: ["Mathematics", "Science", "English", "History"].sample,
          grade_level: 8,
          difficulty: ["Easy", "Medium", "Hard"].sample,
          number_of_questions: [5, 10, 15, 20].sample,
          interests: "sample interests"
        ),
        progress: [0, 25, 50, 75, 100].sample
      }
    end
  end

  def progress_variations
    @progress_variations ||= [
      {
        assignment: Assignment.new(
          id: 1,
          title: "Not Started Assignment",
          subject: "Mathematics",
          grade_level: 8,
          difficulty: "Easy",
          number_of_questions: 10,
          interests: "basic math"
        ),
        progress: 0
      },
      {
        assignment: Assignment.new(
          id: 2,
          title: "In Progress Assignment",
          subject: "Science",
          grade_level: 8,
          difficulty: "Medium",
          number_of_questions: 12,
          interests: "biology, cells"
        ),
        progress: 33
      },
      {
        assignment: Assignment.new(
          id: 3,
          title: "Nearly Complete Assignment",
          subject: "English",
          grade_level: 8,
          difficulty: "Medium",
          number_of_questions: 8,
          interests: "literature, reading"
        ),
        progress: 85
      },
      {
        assignment: Assignment.new(
          id: 4,
          title: "Completed Assignment",
          subject: "History",
          grade_level: 8,
          difficulty: "Hard",
          number_of_questions: 20,
          interests: "american history"
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
          title: "Short Quiz",
          subject: "Mathematics",
          grade_level: 8,
          difficulty: "Easy",
          number_of_questions: 5,
          interests: "arithmetic"
        ),
        progress: 100
      },
      {
        assignment: Assignment.new(
          id: 2,
          title: "Very Long Assignment Title That Should Wrap Nicely Across Multiple Lines",
          subject: "Literature",
          grade_level: 8,
          difficulty: "Hard",
          number_of_questions: 25,
          interests: "creative writing, literature analysis, poetry"
        ),
        progress: 60
      },
      {
        assignment: Assignment.new(
          id: 3,
          title: "Special Characters & Symbols Assignment #2",
          subject: "Computer Science",
          grade_level: 8,
          difficulty: "Medium",
          number_of_questions: 12,
          interests: "programming, symbols"
        ),
        progress: 25
      }
    ]
  end
end 