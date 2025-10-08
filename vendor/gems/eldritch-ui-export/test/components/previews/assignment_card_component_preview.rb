# frozen_string_literal: true

class EldritchUi::AssignmentCardComponentPreview < ViewComponent::Preview
  # 🃏 Assignment Card playground! 🃏
  # ---------------------------------
  # You can use the controls in the 'Params' section
  # to set assignment card property values on the fly.
  #
  # @param title "Assignment title"
  # @param subject select "Subject area" :subject_options
  # @param grade select "Grade level" :grade_options
  # @param difficulty select "Difficulty level" :difficulty_options
  # @param question_count "Number of questions"
  # @param with_image [Boolean] toggle "Show image section?"
  # @param with_actions [Boolean] toggle "Show action buttons?"
  def playground(title: "Fractions and Decimals", subject: :math, grade: :"4th", difficulty: :medium, question_count: 8, with_image: true, with_actions: true)
    render EldritchUi::AssignmentCardComponent.new(
      title: title,
      subject: subject,
      grade: grade,
      difficulty: difficulty,
      question_count: question_count.to_i,
      tags: ["fractions", "decimals", "word problems"]
    ) do |component|
      if with_image
        component.with_image do
          tag.div(
            class: "w-full h-32 bg-gradient-to-br from-blue-400 to-purple-500 rounded-lg flex items-center justify-center",
            style: "background-image: linear-gradient(135deg, #60a5fa 0%, #a855f7 100%);"
          ) do
            tag.span("📚", class: "text-4xl")
          end
        end
      end
      
      if with_actions
        component.with_actions do
          tag.div(class: "flex gap-2") do
            tag.button(
              "Edit",
              type: "button",
              class: "px-3 py-1 bg-blue-500 text-white text-sm rounded hover:bg-blue-600 transition-colors"
            ) + tag.button(
              "Assign",
              type: "button", 
              class: "px-3 py-1 bg-green-500 text-white text-sm rounded hover:bg-green-600 transition-colors"
            )
          end
        end
      end
    end
  end

  # @!group Basic Examples

  # Basic assignment card with minimal content
  def default
    render EldritchUi::AssignmentCardComponent.new(
      title: "Simple Math Quiz",
      subject: "Math",
      grade: "3rd",
      difficulty: "Easy",
      question_count: 5
    )
  end

  # @!group Variants

  # Assignment card with tags but no image or actions
  def with_tags
    render EldritchUi::AssignmentCardComponent.new(
      title: "American Revolution Study Guide",
      subject: "History",
      grade: "8th", 
      difficulty: "Medium",
      question_count: 12,
      tags: ["revolution", "colonial america", "founding fathers"]
    )
  end

  # Assignment card with image content
  def with_image
    render EldritchUi::AssignmentCardComponent.new(
      title: "Plant Life Cycles",
      subject: "Science",
      grade: "5th",
      difficulty: "Medium",
      question_count: 10,
      tags: ["biology", "plants", "life cycles"]
    ) do |component|
      component.with_image do
        tag.div(
          class: "w-full h-32 bg-gradient-to-br from-green-400 to-blue-500 rounded-lg flex items-center justify-center",
          style: "background-image: linear-gradient(135deg, #4ade80 0%, #3b82f6 100%);"
        ) do
          tag.span("🌱", class: "text-4xl")
        end
      end
    end
  end

  # Assignment card with action buttons
  def with_actions
    render EldritchUi::AssignmentCardComponent.new(
      title: "Creative Writing Prompts",
      subject: "English",
      grade: "6th",
      difficulty: "Medium", 
      question_count: 6,
      tags: ["writing", "creativity", "storytelling"]
    ) do |component|
      component.with_actions do
        tag.div(class: "flex gap-2") do
          tag.button(
            "Edit Assignment",
            type: "button",
            class: "px-3 py-1 bg-blue-500 text-white text-sm rounded hover:bg-blue-600 transition-colors"
          ) + tag.button(
            "Assign to Students", 
            type: "button",
            class: "px-3 py-1 bg-green-500 text-white text-sm rounded hover:bg-green-600 transition-colors"
          ) + tag.button(
            "Duplicate",
            type: "button", 
            class: "px-2 py-1 bg-gray-500 text-white text-sm rounded hover:bg-gray-600 transition-colors"
          )
        end
      end
    end
  end

  # Complete assignment card with all features
  def complete
    render EldritchUi::AssignmentCardComponent.new(
      title: "Solar System Exploration",
      subject: "Science",
      grade: "7th",
      difficulty: "Hard",
      question_count: 15,
      tags: ["astronomy", "planets", "space exploration"]
    ) do |component|
      component.with_image do
        tag.div(
          class: "w-full h-32 bg-gradient-to-br from-purple-600 to-blue-800 rounded-lg flex items-center justify-center",
          style: "background-image: linear-gradient(135deg, #7c3aed 0%, #1e40af 100%);"
        ) do
          tag.span("🚀", class: "text-4xl")
        end
      end
      
      component.with_actions do
        tag.div(class: "flex gap-2") do
          tag.button(
            "Edit",
            type: "button",
            class: "px-3 py-1 bg-blue-500 text-white text-sm rounded hover:bg-blue-600 transition-colors"
          ) + tag.button(
            "Assign",
            type: "button",
            class: "px-3 py-1 bg-green-500 text-white text-sm rounded hover:bg-green-600 transition-colors"
          ) + tag.button(
            "Share",
            type: "button",
            class: "px-2 py-1 bg-purple-500 text-white text-sm rounded hover:bg-purple-600 transition-colors"
          )
        end
      end
    end
  end

  # @!group Texture Examples

  # Different parchment texture intensities
  def texture_variants
    tag.div(class: "space-y-6") do
      tag.h3("Texture Variants", class: "text-lg font-semibold mb-4") +
      tag.div(class: "grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4") do
        [
          { class: "eld-texture-parchment--light", label: "Light Texture (Default)" },
          { class: "eld-texture-parchment--medium", label: "Medium Texture" },
          { class: "eld-texture-parchment--strong", label: "Strong Texture" },
          { class: "eld-texture-parchment", label: "Full Texture" }
        ].map do |variant|
          tag.div(class: "space-y-2") do
            tag.h4(variant[:label], class: "text-sm font-medium text-gray-700") +
            render(EldritchUi::AssignmentCardComponent.new(
              title: "Texture Demo",
              subject: "Art",
              grade: "5th",
              difficulty: "Medium",
              question_count: 8,
              tags: ["textures", "demo"],
              class: variant[:class]
            ))
          end
        end.join.html_safe
      end
    end
  end

  # @!group Layout Examples

  # Grid layout demonstration with multiple cards
  def grid_layout
    tag.div(class: "grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4") do
      assignments = [
        { title: "Multiplication Tables", subject: "Math", grade: "3rd", difficulty: "Easy", count: 8, tags: ["multiplication", "times tables"] },
        { title: "Poetry Analysis", subject: "English", grade: "9th", difficulty: "Hard", count: 6, tags: ["poetry", "literature", "analysis"] },
        { title: "Chemical Reactions", subject: "Science", grade: "10th", difficulty: "Expert", count: 12, tags: ["chemistry", "reactions", "lab"] },
        { title: "World War II", subject: "History", grade: "11th", difficulty: "Medium", count: 10, tags: ["wwii", "history", "warfare"] },
        { title: "Abstract Art", subject: "Art", grade: "7th", difficulty: "Medium", count: 5, tags: ["abstract", "creativity", "expression"] },
        { title: "Fractions Practice", subject: "Math", grade: "4th", difficulty: "Medium", count: 7, tags: ["fractions", "practice", "arithmetic"] }
      ]
      
      safe_join(assignments.map do |assignment|
        render(EldritchUi::AssignmentCardComponent.new(
          title: assignment[:title],
          subject: assignment[:subject], 
          grade: assignment[:grade],
          difficulty: assignment[:difficulty],
          question_count: assignment[:count],
          tags: assignment[:tags]
        ))
      end)
    end
  end

  private

  def subject_options
    [:math, :science, :english, :history, :art]
  end

  def grade_options
    [:K, :"1st", :"2nd", :"3rd", :"4th", :"5th", :"6th", :"7th", :"8th", :"9th", :"10th", :"11th", :"12th"]
  end

  def difficulty_options
    [:easy, :medium, :hard, :expert]
  end
end