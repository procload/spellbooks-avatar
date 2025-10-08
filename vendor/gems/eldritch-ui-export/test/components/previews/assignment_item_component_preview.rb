# frozen_string_literal: true

# @!group Display Components

# Assignment Item Component
#
# Simpler, list-focused version of assignment display
# Good for tables, search results, assignment lists
class EldritchUi::AssignmentItemComponentPreview < ViewComponent::Preview
  # 🎯 Assignment Item playground! 🎯
  # ----------------------------------
  # You can use the controls in the 'Params' section
  # to set assignment item property values on the fly.
  #
  # @param title "Assignment title"
  # @param subject select "Subject area" :subject_options
  # @param grade select "Grade level" :grade_options
  # @param difficulty select "Difficulty level" :difficulty_options
  # @param question_count "Number of questions"
  # @param size select "Size variant" :size_options
  # @param clickable [Boolean] toggle "Is clickable?"
  # @param with_icon [Boolean] toggle "Show icon?"
  # @param with_actions [Boolean] toggle "Show actions?"
  def playground(title: "Fractions and Decimals", subject: :math, grade: :"4th", difficulty: :medium, question_count: 8, size: :default, clickable: false, with_icon: false, with_actions: false)
    component = EldritchUi::AssignmentItemComponent.new(
      title: title,
      subject: subject,
      grade: grade,
      difficulty: difficulty,
      question_count: question_count.to_i,
      tags: ["fractions", "decimals", "word problems"],
      size: size,
      clickable: clickable
    )

    if with_icon
      component.with_icon do
        render EldritchUi::IconComponent.new(name: "academic-cap", size: :small)
      end
    end

    if with_actions
      component.with_actions do
        '<div class="flex gap-2">
          <button class="px-2 py-1 text-xs bg-blue-500 text-white rounded hover:bg-blue-600">Edit</button>
          <button class="px-2 py-1 text-xs bg-green-500 text-white rounded hover:bg-green-600">Assign</button>
        </div>'.html_safe
      end
    end

    render component
  end

  # @!group Basic Examples

  # Basic assignment item with minimal content
  def default
    render EldritchUi::AssignmentItemComponent.new(
      title: "Simple Math Quiz",
      subject: "Math",
      grade: "3rd",
      difficulty: "Easy",
      question_count: 5
    )
  end

  # Assignment item with description metadata
  def with_description
    render EldritchUi::AssignmentItemComponent.new(
      title: "American Revolution Study Guide",
      subject: "History",
      grade: "8th",
      difficulty: "Medium",
      question_count: 12
    )
  end

  # Assignment item with tags
  def with_tags
    render EldritchUi::AssignmentItemComponent.new(
      title: "Plant Life Cycles",
      subject: "Science",
      grade: "5th",
      difficulty: "Medium",
      question_count: 10,
      tags: ["biology", "plants", "life cycles", "photosynthesis"]
    )
  end

  # @!group Size Variants

  # Default size variant
  def default_size
    render EldritchUi::AssignmentItemComponent.new(
      title: "Creative Writing Prompts",
      subject: "English",
      grade: "6th",
      difficulty: "Medium",
      question_count: 6,
      tags: ["writing", "creativity", "storytelling"],
      size: :default
    )
  end

  # Compact size variant (good for dense lists)
  def compact_size
    render EldritchUi::AssignmentItemComponent.new(
      title: "Multiplication Tables Practice",
      subject: "Math",
      grade: "3rd",
      difficulty: "Easy",
      question_count: 20,
      tags: ["multiplication", "times tables", "arithmetic"],
      size: :compact
    )
  end

  # @!group Interactive States

  # Clickable assignment item (button behavior)
  def clickable_item
    render EldritchUi::AssignmentItemComponent.new(
      title: "Interactive Geometry",
      subject: "Math",
      grade: "7th",
      difficulty: "Hard",
      question_count: 15,
      tags: ["geometry", "shapes", "angles"],
      clickable: true
    )
  end

  # Assignment item as a link
  def as_link
    render EldritchUi::AssignmentItemComponent.new(
      title: "Solar System Exploration",
      subject: "Science",
      grade: "5th",
      difficulty: "Medium",
      question_count: 18,
      tags: ["astronomy", "planets", "space"],
      href: "/assignments/solar-system"
    )
  end

  # @!group With Icons

  # Assignment item with academic icon
  def with_academic_icon
    component = EldritchUi::AssignmentItemComponent.new(
      title: "Advanced Calculus",
      subject: "Mathematics",
      grade: "12th",
      difficulty: "Expert",
      question_count: 25,
      tags: ["calculus", "derivatives", "integrals"]
    )

    component.with_icon do
      render EldritchUi::IconComponent.new(name: "academic-cap", size: :small)
    end

    render component
  end

  # Assignment item with subject-specific icon
  def with_science_icon
    component = EldritchUi::AssignmentItemComponent.new(
      title: "Chemical Reactions Lab",
      subject: "Chemistry",
      grade: "10th",
      difficulty: "Hard",
      question_count: 12,
      tags: ["chemistry", "reactions", "lab work"]
    )

    component.with_icon do
      render EldritchUi::IconComponent.new(name: "light-bulb", size: :small)
    end

    render component
  end

  # Assignment item with creative icon
  def with_creative_icon
    component = EldritchUi::AssignmentItemComponent.new(
      title: "Poetry Analysis Workshop",
      subject: "Literature",
      grade: "9th",
      difficulty: "Medium",
      question_count: 8,
      tags: ["poetry", "literature", "analysis"]
    )

    component.with_icon do
      render EldritchUi::IconComponent.new(name: "sparkles", size: :small)
    end

    render component
  end

  # @!group With Actions

  # Assignment item with single action
  def with_single_action
    component = EldritchUi::AssignmentItemComponent.new(
      title: "Reading Comprehension Test",
      subject: "English",
      grade: "4th",
      difficulty: "Easy",
      question_count: 10,
      tags: ["reading", "comprehension"]
    )

    component.with_actions do
      '<button class="px-3 py-1 text-sm bg-blue-500 text-white rounded hover:bg-blue-600 transition-colors">
        Edit
      </button>'.html_safe
    end

    render component
  end

  # Assignment item with multiple actions
  def with_multiple_actions
    component = EldritchUi::AssignmentItemComponent.new(
      title: "World Geography Quiz",
      subject: "Geography",
      grade: "6th",
      difficulty: "Medium",
      question_count: 15,
      tags: ["geography", "countries", "capitals"]
    )

    component.with_actions do
      '<div class="flex gap-1">
        <button class="px-2 py-1 text-xs bg-blue-500 text-white rounded hover:bg-blue-600">Edit</button>
        <button class="px-2 py-1 text-xs bg-green-500 text-white rounded hover:bg-green-600">Assign</button>
        <button class="px-2 py-1 text-xs bg-purple-500 text-white rounded hover:bg-purple-600">Share</button>
      </div>'.html_safe
    end

    render component
  end

  # @!group Complete Examples

  # Complete assignment item with all features
  def complete_example
    component = EldritchUi::AssignmentItemComponent.new(
      title: "Advanced Physics: Quantum Mechanics",
      subject: "Physics",
      grade: "12th",
      difficulty: "Expert",
      question_count: 30,
      tags: ["physics", "quantum", "mechanics", "advanced"],
      href: "/assignments/quantum-physics",
      size: :default,
      class: "featured-assignment",
      data: { category: "advanced-science" }
    )

    component.with_icon do
      render EldritchUi::IconComponent.new(name: "light-bulb", size: :small)
    end

    component.with_actions do
      '<div class="flex gap-1">
        <button class="px-2 py-1 text-xs bg-blue-500 text-white rounded hover:bg-blue-600">Edit</button>
        <button class="px-2 py-1 text-xs bg-green-500 text-white rounded hover:bg-green-600">Assign</button>
        <button class="px-2 py-1 text-xs bg-red-500 text-white rounded hover:bg-red-600">Delete</button>
      </div>'.html_safe
    end

    render component
  end

  # Minimal assignment item
  def minimal_example
    render EldritchUi::AssignmentItemComponent.new(
      title: "Basic Spelling Test",
      subject: "English",
      grade: "2nd",
      difficulty: "Easy",
      question_count: 10
    )
  end

  # @!group List Examples

  # Assignment item for list context (single example)
  def list_context
    component = EldritchUi::AssignmentItemComponent.new(
      title: "Multiplication Tables",
      subject: "Math",
      grade: "3rd",
      difficulty: "Easy",
      question_count: 8,
      tags: ["multiplication"],
      href: "/assignments/1",
      size: :default
    )

    component.with_actions do
      '<div class="flex gap-1">
        <button class="px-2 py-1 text-xs bg-blue-500 text-white rounded">Edit</button>
        <button class="px-2 py-1 text-xs bg-green-500 text-white rounded">Assign</button>
      </div>'.html_safe
    end

    render component
  end

  # Compact list item for dense display
  def compact_list
    render EldritchUi::AssignmentItemComponent.new(
      title: "Addition Practice",
      subject: "Math",
      grade: "1st",
      difficulty: "Easy",
      question_count: 15,
      size: :compact,
      clickable: true
    )
  end

  # History assignment for list context
  def list_history_item
    component = EldritchUi::AssignmentItemComponent.new(
      title: "World War II",
      subject: "History",
      grade: "11th",
      difficulty: "Medium",
      question_count: 10,
      tags: ["history", "wwii"],
      href: "/assignments/history-1"
    )

    component.with_actions do
      '<button class="px-2 py-1 text-xs bg-blue-500 text-white rounded">Edit</button>'.html_safe
    end

    render component
  end

  # Science assignment for list context
  def list_science_item
    render EldritchUi::AssignmentItemComponent.new(
      title: "Chemical Reactions",
      subject: "Science",
      grade: "10th",
      difficulty: "Expert",
      question_count: 12,
      tags: ["chemistry"],
      href: "/assignments/science-1",
      clickable: true
    )
  end

  # @!group Search Results Examples

  # Search result item with search icon
  def search_results
    component = EldritchUi::AssignmentItemComponent.new(
      title: "Fractions and Decimals Workshop",
      subject: "Math",
      grade: "4th",
      difficulty: "Medium",
      question_count: 12,
      tags: ["fractions", "decimals"],
      href: "/assignments/search-1"
    )

    component.with_icon do
      render EldritchUi::IconComponent.new(name: "search", size: :small)
    end

    render component
  end

  # @!group Edge Cases

  # Very long title example
  def long_title
    render EldritchUi::AssignmentItemComponent.new(
      title: "This is a Very Long Assignment Title That Demonstrates How the Component Handles Extensive Text Content and Maintains Proper Layout",
      subject: "Literature",
      grade: "12th",
      difficulty: "Expert",
      question_count: 50,
      tags: ["comprehensive", "literature", "analysis", "critical thinking", "advanced placement"]
    )
  end

  # Single question assignment
  def single_question
    render EldritchUi::AssignmentItemComponent.new(
      title: "Daily Math Challenge",
      subject: "Math",
      grade: "5th",
      difficulty: "Hard",
      question_count: 1,
      tags: ["challenge", "daily"]
    )
  end

  # Assignment with many tags
  def many_tags
    render EldritchUi::AssignmentItemComponent.new(
      title: "Comprehensive Science Review",
      subject: "Science",
      grade: "8th",
      difficulty: "Medium",
      question_count: 35,
      tags: ["biology", "chemistry", "physics", "earth science", "astronomy", "ecology", "genetics", "evolution"]
    )
  end

  # @!group Mobile Examples

  # Mobile-responsive example
  def mobile_responsive
    component = EldritchUi::AssignmentItemComponent.new(
      title: "Mobile-Friendly Assignment",
      subject: "Technology",
      grade: "9th",
      difficulty: "Medium",
      question_count: 15,
      tags: ["technology", "mobile", "responsive"],
      href: "/assignments/mobile"
    )

    component.with_icon do
      render EldritchUi::IconComponent.new(name: "device-phone-mobile", size: :small)
    end

    component.with_actions do
      '<div class="flex gap-1">
        <button class="px-2 py-1 text-xs bg-blue-500 text-white rounded">Edit</button>
        <button class="px-2 py-1 text-xs bg-green-500 text-white rounded">Share</button>
      </div>'.html_safe
    end

    render component
  end

  private

  def subject_options
    [:math, :english, :science, :history, :art, :music, :physical_education, :technology, :geography]
  end

  def grade_options
    [:K, :"1st", :"2nd", :"3rd", :"4th", :"5th", :"6th", :"7th", :"8th", :"9th", :"10th", :"11th", :"12th"]
  end

  def difficulty_options
    [:easy, :medium, :hard, :expert]
  end

  def size_options
    [:default, :compact]
  end
end 