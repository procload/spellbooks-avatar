class EldritchUi::StudentAssignmentsContainerComponentPreview < ViewComponent::Preview
  # Default preview with multiple students and assignments
  def default
    students = [
      OpenStruct.new(id: 1, first_name: "Alice", last_name: "Johnson", email_address: "alice.johnson@example.com"),
      OpenStruct.new(id: 2, first_name: "Bob", last_name: "Smith", email_address: "bob.smith@example.com"),
      OpenStruct.new(id: 3, first_name: "Carol", last_name: "Williams", email_address: "carol.williams@example.com")
    ]
    
    assignments_by_student = {
      1 => [
        { 
          assignment: create_assignment("Math Quiz", "Mathematics", "grade_3"),
          progress: 85 
        },
        { 
          assignment: create_assignment("Science Test", "Science", "grade_3"),
          progress: 72 
        }
      ],
      2 => [
        { 
          assignment: create_assignment("Math Quiz", "Mathematics", "grade_3"),
          progress: 100 
        }
      ],
      3 => [
        { 
          assignment: create_assignment("Reading Comprehension", "English", "grade_3"),
          progress: 45 
        },
        { 
          assignment: create_assignment("History Quiz", "Social Studies", "grade_3"),
          progress: 91 
        },
        { 
          assignment: create_assignment("Art Project", "Art", "grade_3"),
          progress: 33 
        }
      ]
    }
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: assignments_by_student
    )
  end

  # Empty state with no students
  def empty_state
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: []
    )
  end

  # Students without any assignments
  def students_no_assignments
    students = [
      OpenStruct.new(id: 1, first_name: "Alice", last_name: "Johnson", email_address: "alice.johnson@example.com"),
      OpenStruct.new(id: 2, first_name: "Bob", last_name: "Smith", email_address: "bob.smith@example.com")
    ]
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: {}
    )
  end

  # Single student with multiple assignments
  def single_student_multiple_assignments
    student = OpenStruct.new(id: 1, first_name: "Alice", last_name: "Johnson", email_address: "alice.johnson@example.com")
    
    assignments_by_student = {
      1 => [
        { 
          assignment: create_assignment("Math Quiz", "Mathematics", "grade_3"),
          progress: 85 
        },
        { 
          assignment: create_assignment("Science Test", "Science", "grade_3"),
          progress: 72 
        },
        { 
          assignment: create_assignment("Reading Comprehension", "English", "grade_3"),
          progress: 45 
        },
        { 
          assignment: create_assignment("History Quiz", "Social Studies", "grade_3"),
          progress: 91 
        }
      ]
    }
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: [student],
      assignments_by_student: assignments_by_student
    )
  end

  # Students with mixed assignment states
  def mixed_assignment_states
    students = [
      OpenStruct.new(id: 1, first_name: "Alice", last_name: "Johnson", email_address: "alice.johnson@example.com"),
      OpenStruct.new(id: 2, first_name: "Bob", last_name: "Smith", email_address: "bob.smith@example.com"),
      OpenStruct.new(id: 3, first_name: "Carol", last_name: "Williams", email_address: "carol.williams@example.com")
    ]
    
    assignments_by_student = {
      1 => [
        { 
          assignment: create_assignment("Math Quiz", "Mathematics", "grade_3"),
          progress: 100 
        }
      ],
      # Bob has no assignments (will show empty message)
      3 => [
        { 
          assignment: create_assignment("Science Test", "Science", "grade_3"),
          progress: 0 
        },
        { 
          assignment: create_assignment("Reading Test", "English", "grade_3"),
          progress: 15 
        }
      ]
    }
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: assignments_by_student
    )
  end

  # Students without email addresses
  def students_without_emails
    students = [
      OpenStruct.new(id: 1, first_name: "Alice", last_name: "Johnson", email_address: nil),
      OpenStruct.new(id: 2, first_name: "Bob", last_name: "Smith", email_address: "")
    ]
    
    assignments_by_student = {
      1 => [
        { 
          assignment: create_assignment("Math Quiz", "Mathematics", "grade_3"),
          progress: 75 
        }
      ]
    }
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: assignments_by_student
    )
  end

  # Students with long names and emails
  def long_names_and_emails
    students = [
      OpenStruct.new(
        id: 1, 
        first_name: "Alexandrina Josephine", 
        last_name: "Worthington-Smythe", 
        email_address: "alexandrina.josephine.worthington-smythe@verylongschooldistrictname.university.edu"
      ),
      OpenStruct.new(
        id: 2, 
        first_name: "Christopher", 
        last_name: "Van Der Berg-Williams", 
        email_address: "c.vandeberg.williams@school.example.edu"
      )
    ]
    
    assignments_by_student = {
      1 => [
        { 
          assignment: create_assignment("Advanced Mathematics Problem Set", "Mathematics", "grade_5"),
          progress: 65 
        }
      ],
      2 => [
        { 
          assignment: create_assignment("Creative Writing Assignment", "English", "grade_5"),
          progress: 88 
        }
      ]
    }
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: assignments_by_student
    )
  end

  # Many students (stress test)
  def many_students
    students = (1..12).map do |i|
      OpenStruct.new(
        id: i, 
        first_name: "Student", 
        last_name: "#{i.to_s.rjust(2, '0')}", 
        email_address: "student#{i}@example.com"
      )
    end
    
    assignments_by_student = {}
    students.each_with_index do |student, index|
      assignments_by_student[student.id] = [
        { 
          assignment: create_assignment("Assignment #{index + 1}", "Subject", "grade_3"),
          progress: rand(0..100) 
        }
      ]
    end
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: assignments_by_student
    )
  end

  # Progress variations
  def progress_variations
    students = [
      OpenStruct.new(id: 1, first_name: "Perfect", last_name: "Student", email_address: "perfect@example.com"),
      OpenStruct.new(id: 2, first_name: "Starting", last_name: "Student", email_address: "starting@example.com"),
      OpenStruct.new(id: 3, first_name: "Halfway", last_name: "Student", email_address: "halfway@example.com"),
      OpenStruct.new(id: 4, first_name: "Almost", last_name: "Done", email_address: "almost@example.com")
    ]
    
    assignments_by_student = {
      1 => [
        { 
          assignment: create_assignment("Perfect Assignment", "Mathematics", "grade_3"),
          progress: 100 
        }
      ],
      2 => [
        { 
          assignment: create_assignment("Just Started", "Science", "grade_3"),
          progress: 5 
        }
      ],
      3 => [
        { 
          assignment: create_assignment("Halfway There", "English", "grade_3"),
          progress: 50 
        }
      ],
      4 => [
        { 
          assignment: create_assignment("Nearly Complete", "History", "grade_3"),
          progress: 95 
        }
      ]
    }
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: assignments_by_student
    )
  end

  # Custom CSS classes
  def custom_styling
    students = [
      OpenStruct.new(id: 1, first_name: "Styled", last_name: "Student", email_address: "styled@example.com")
    ]
    
    assignments_by_student = {
      1 => [
        { 
          assignment: create_assignment("Custom Style Assignment", "Art", "grade_3"),
          progress: 75 
        }
      ]
    }
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: assignments_by_student,
      class: "custom-container-class",
      style: "border: 2px solid #e5e7eb; border-radius: 8px;"
    )
  end

  # Hidden empty message
  def hidden_empty_message
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: [],
      show_empty_message: false
    )
  end

  # Mobile layout preview (narrow container)
  def mobile_layout
    students = [
      OpenStruct.new(id: 1, first_name: "Mobile", last_name: "User", email_address: "mobile.user@example.com"),
      OpenStruct.new(id: 2, first_name: "Another", last_name: "Student", email_address: "another@example.com")
    ]
    
    assignments_by_student = {
      1 => [
        { 
          assignment: create_assignment("Mobile Assignment", "Technology", "grade_4"),
          progress: 60 
        },
        { 
          assignment: create_assignment("Responsive Design", "Art", "grade_4"),
          progress: 80 
        }
      ],
      2 => [
        { 
          assignment: create_assignment("Small Screen Test", "Mathematics", "grade_4"),
          progress: 40 
        }
      ]
    }
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: assignments_by_student,
      style: "max-width: 375px; margin: 0 auto;"
    )
  end

  # Assignment data edge cases
  def assignment_edge_cases
    students = [
      OpenStruct.new(id: 1, first_name: "Edge", last_name: "Case", email_address: "edge@example.com")
    ]
    
    # Include various edge cases for assignment data
    assignments_by_student = {
      1 => [
        { 
          assignment: create_assignment("Normal Assignment", "Mathematics", "grade_3"),
          progress: 75 
        },
        { 
          assignment: create_assignment("Zero Progress", "Science", "grade_3"),
          progress: 0 
        },
        { 
          assignment: create_assignment("Complete Assignment", "English", "grade_3"),
          progress: 100 
        }
      ]
    }
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: assignments_by_student
    )
  end

  # Print preview (suitable for printing)
  def print_preview
    students = [
      OpenStruct.new(id: 1, first_name: "Print", last_name: "Student", email_address: "print@example.com"),
      OpenStruct.new(id: 2, first_name: "Report", last_name: "User", email_address: "report@example.com")
    ]
    
    assignments_by_student = {
      1 => [
        { 
          assignment: create_assignment("Printable Assignment", "Mathematics", "grade_3"),
          progress: 85 
        },
        { 
          assignment: create_assignment("Report Card Item", "Science", "grade_3"),
          progress: 92 
        }
      ],
      2 => [
        { 
          assignment: create_assignment("Summary Assignment", "English", "grade_3"),
          progress: 78 
        }
      ]
    }
    
    render EldritchUi::StudentAssignmentsContainerComponent.new(
      students: students,
      assignments_by_student: assignments_by_student,
      style: "background: white; color: black; font-family: serif;"
    )
  end

  private

  def create_assignment(title, subject, grade_level)
    OpenStruct.new(
      id: rand(1000..9999),
      title: title,
      subject: subject,
      grade_level: grade_level,
      difficulty: ["easy", "medium", "hard"].sample,
      number_of_questions: rand(5..25),
      interests: ["science", "art", "sports"].sample(rand(1..3))
    )
  end
end 