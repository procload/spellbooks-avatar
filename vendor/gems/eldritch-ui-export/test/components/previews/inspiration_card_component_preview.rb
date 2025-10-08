# frozen_string_literal: true

# @!group Display Components

# Inspiration Card Component
#
# Displays template suggestions for quickly creating new assignments.
# Used on assignment creation pages to provide pre-configured templates.
class EldritchUi::InspirationCardComponentPreview < ViewComponent::Preview
  # @!group Basic Examples
  
  # Default inspiration card with just a title
  def default
    render EldritchUi::InspirationCardComponent.new(
      title: "Basic Assignment Template"
    )
  end

  # Card with title and subtitle
  def with_subtitle
    render EldritchUi::InspirationCardComponent.new(
      title: "Math Fundamentals Worksheet",
      subtitle: "3RD GRADE"
    )
  end

  # Card with tags
  def with_tags
    render EldritchUi::InspirationCardComponent.new(
      title: "Creative Writing Exercise",
      subtitle: "4TH GRADE",
      tags: ["Writing", "Creativity", "Story Structure"]
    )
  end

  # Card with student count
  def with_students_count
    render EldritchUi::InspirationCardComponent.new(
      title: "Science Experiment Lab",
      subtitle: "5TH GRADE",
      students_count: 28
    )
  end

  # @!group Action Types

  # Card with template key action
  def with_template_action
    render EldritchUi::InspirationCardComponent.new(
      title: "Pikachu Adventure Story",
      subtitle: "1ST GRADE",
      tags: ["Pokemon", "Adventure", "Reading"],
      students_count: 22,
      template_key: "pikachu_story"
    )
  end

  # Card with href action
  def with_href_action
    render EldritchUi::InspirationCardComponent.new(
      title: "Custom Assignment Builder",
      subtitle: "ALL GRADES",
      tags: ["Flexible", "Customizable"],
      href: "/assignments/new"
    )
  end

  # @!group With Icons

  # Card with academic icon
  def with_academic_icon
    render EldritchUi::InspirationCardComponent.new(
      title: "Advanced Mathematics",
      subtitle: "6TH GRADE",
      tags: ["Algebra", "Problem Solving"],
      students_count: 15,
      icon_name: "academic-cap",
      template_key: "advanced_math"
    )
  end

  # Card with science icon
  def with_science_icon
    render EldritchUi::InspirationCardComponent.new(
      title: "Chemistry Lab Safety",
      subtitle: "7TH GRADE",
      tags: ["Chemistry", "Lab", "Safety"],
      students_count: 20,
      icon_name: "light-bulb",
      template_key: "chemistry_lab"
    )
  end

  # Card with sparkles icon
  def with_sparkles_icon
    render EldritchUi::InspirationCardComponent.new(
      title: "Magic and Mythology",
      subtitle: "2ND GRADE",
      tags: ["Fantasy", "Mythology", "Creative"],
      students_count: 18,
      icon_name: "sparkles",
      template_key: "mythology_quiz"
    )
  end

  # @!group Complete Examples

  # Full-featured inspiration card
  def complete_example
    render EldritchUi::InspirationCardComponent.new(
      title: "Interactive History Timeline",
      subtitle: "8TH GRADE",
      tags: ["History", "Timeline", "Interactive", "Research"],
      students_count: 32,
      icon_name: "clock",
      template_key: "history_timeline",
      class: "featured-template"
    )
  end

  # Pokemon-themed card (matching legacy usage)
  def pokemon_themed
    render EldritchUi::InspirationCardComponent.new(
      title: "My Pikachu Story Assignment",
      subtitle: "1ST GRADE",
      tags: ["Pokemon", "Pikachu", "Basketball"],
      students_count: 50,
      icon_name: "sparkles",
      template_key: "pikachu_story"
    )
  end

  # Math worksheet card (matching legacy usage)
  def math_worksheet
    render EldritchUi::InspirationCardComponent.new(
      title: "Math Worksheet",
      subtitle: "3RD GRADE",
      tags: ["Addition", "Subtraction", "Multiplication"],
      students_count: 30,
      icon_name: "academic-cap",
      template_key: "math_worksheet"
    )
  end

  # Science experiment card (matching legacy usage)
  def science_experiment
    render EldritchUi::InspirationCardComponent.new(
      title: "Science Experiment",
      subtitle: "5TH GRADE",
      tags: ["Chemistry", "Lab", "Observation"],
      students_count: 25,
      icon_name: "light-bulb",
      template_key: "science_experiment"
    )
  end

  # @!group Edge Cases

  # Card with single tag
  def single_tag
    render EldritchUi::InspirationCardComponent.new(
      title: "Reading Comprehension",
      subtitle: "2ND GRADE",
      tags: ["Reading"],
      template_key: "reading_basic"
    )
  end

  # Card with many tags
  def many_tags
    render EldritchUi::InspirationCardComponent.new(
      title: "Comprehensive Language Arts",
      subtitle: "6TH GRADE",
      tags: [
        "Reading", "Writing", "Grammar", "Vocabulary", 
        "Literature", "Poetry", "Essays", "Research"
      ],
      students_count: 24,
      template_key: "language_arts_comprehensive"
    )
  end

  # Card with single student
  def single_student
    render EldritchUi::InspirationCardComponent.new(
      title: "Individual Tutoring Session",
      subtitle: "PERSONALIZED",
      tags: ["One-on-One", "Customized"],
      students_count: 1,
      template_key: "individual_session"
    )
  end

  # Card with long title
  def long_title
    render EldritchUi::InspirationCardComponent.new(
      title: "Advanced Comprehensive Mathematics Problem-Solving and Critical Thinking Workshop",
      subtitle: "ADVANCED PLACEMENT",
      tags: ["Advanced", "Mathematics", "Problem Solving"],
      students_count: 12,
      template_key: "advanced_math_workshop"
    )
  end

  # @!group Custom Actions with Slots

  # Card with custom template action
  def custom_template_action
    render EldritchUi::InspirationCardComponent.new(
      title: "Custom Template Design",
      subtitle: "TEACHER TOOLS",
      tags: ["Templates", "Design", "Custom"],
      template_key: "custom_design"
    )
  end

  # Card with custom link action
  def custom_link_action
    render EldritchUi::InspirationCardComponent.new(
      title: "External Learning Resource",
      subtitle: "SUPPLEMENTARY",
      tags: ["External", "Resources", "Learning"],
      href: "https://example.com/resource"
    )
  end

  # @!group States and Variants

  # Card with custom CSS class
  def with_custom_styling
    render EldritchUi::InspirationCardComponent.new(
      title: "Featured Premium Template",
      subtitle: "PREMIUM",
      tags: ["Premium", "Featured", "Popular"],
      students_count: 45,
      icon_name: "star",
      template_key: "premium_template",
      class: "border-2 border-yellow-400 bg-yellow-50"
    )
  end

  # Card without any optional features
  def minimal_card
    render EldritchUi::InspirationCardComponent.new(
      title: "Simple Assignment"
    )
  end
end 