class EldritchUi::ReadingPassageComponentPreview < ViewComponent::Preview
  # @!group Basic Variants
  def default
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content
    )
  end

  def with_title
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      title: "The Ancient Forest"
    )
  end

  def with_title_and_metadata
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      title: "Ultima Online Dragon Sports",
      subject: "History",
      grade_level: 7,
      difficulty: "easy",
      interests: ["dragons", "sports", "gaming"]
    )
  end

  def with_short_content
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: "# Brief Passage\n\nThis is a short reading passage for testing layout with minimal content."
    )
  end

  def with_long_content
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: long_sample_content
    )
  end

  # @!group Image Positioning
  def with_image_right
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      image: sample_image,
      image_position: :right
    )
  end

  def with_image_left
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      image: sample_image,
      image_position: :left
    )
  end

  def with_image_top
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      image: sample_image,
      image_position: :top
    )
  end

  def with_image_inline
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      image: sample_image,
      image_position: :inline
    )
  end

  # @!group Editable Mode
  def editable_mode
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      editable: true,
      data: {
        controller: "markdown-editor",
        "markdown-editor-update-url-value": "/assignments/1/update_passage"
      }
    )
  end

  def editable_with_image
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      image: sample_image,
      editable: true,
      data: {
        controller: "markdown-editor",
        "markdown-editor-update-url-value": "/assignments/1/update_passage"
      }
    )
  end

  def editable_custom_buttons
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      editable: true,
      edit_button_text: "Modify Content",
      save_button_text: "Apply Changes",
      data: {
        controller: "markdown-editor",
        "markdown-editor-update-url-value": "/assignments/1/update_passage"
      }
    )
  end

  # @!group Content Types
  def rich_markdown_content
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: rich_markdown_sample
    )
  end

  def content_with_lists
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: list_content_sample
    )
  end

  def content_with_blockquote
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: blockquote_content_sample
    )
  end

  # @!group Edge Cases
  def empty_content
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: ""
    )
  end

  def minimal_content
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: "Just a single sentence."
    )
  end

  def content_with_special_characters
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: "# Special Characters\n\nContent with symbols: @#$%^&*()_+-=[]{}|;':\",./<>? and unicode: émojis 🎉 ñiño"
    )
  end

  # @!group Custom Styling
  def with_custom_class
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      class: "custom-passage-styling"
    )
  end

  def with_data_attributes
    render EldritchUi::ReadingPassageComponent.new(
      passage_content: sample_markdown_content,
      data: {
        controller: "custom-controller",
        "custom-value": "test-value"
      }
    )
  end

  private

  def sample_markdown_content
    <<~MARKDOWN
      # The Ancient Forest

      Deep within the **Whispering Woods**, where sunlight barely penetrates the dense canopy, lies a grove that has remained unchanged for centuries. The trees here are *ancient guardians*, their massive trunks telling stories of ages long past.

      ## The Discovery

      Sarah carefully stepped over the moss-covered stones, her eyes adjusting to the dim light filtering through the leaves above. She had been searching for this place for months, following clues from her grandmother's journal.

      As she entered the clearing, she gasped. Before her stood the most magnificent oak tree she had ever seen, its branches reaching toward the sky like outstretched arms welcoming the heavens.
    MARKDOWN
  end

  def long_sample_content
    <<~MARKDOWN
      # The Scientific Method in Medieval Times

      ## Introduction

      The development of scientific thinking during the medieval period represents a fascinating chapter in human intellectual history. While often overshadowed by the Renaissance that followed, the medieval era laid crucial groundwork for modern scientific methodology.

      ## Early Foundations

      Medieval scholars, working within the framework of religious institutions, began to develop systematic approaches to understanding the natural world. **Monasteries became centers of learning**, preserving ancient texts and conducting observations of natural phenomena.

      ### Key Figures

      Notable medieval scientists included:

      1. **Roger Bacon** (1214-1294) - Emphasized experimental methodology
      2. **Albert the Great** (1200-1280) - Made extensive observations of plants and animals
      3. **Robert Grosseteste** (1175-1253) - Developed theories about light and optics

      ## Experimental Approaches

      Despite limitations in technology and institutional constraints, medieval scholars developed remarkably sophisticated approaches to investigation. They understood the importance of *systematic observation* and began to question traditional authorities.

      > "The strongest arguments prove nothing so long as the conclusions are not verified by experience." - Roger Bacon

      ### Agricultural Innovations

      Medieval scientists made significant contributions to agricultural science, developing new techniques for:

      - Crop rotation systems
      - Soil improvement methods
      - Weather prediction
      - Animal husbandry

      ## Mathematical Developments

      The period saw important advances in mathematics, particularly in:

      - **Algebra** - Through translation of Arabic texts
      - **Geometry** - Building on Euclidean principles
      - **Astronomical calculations** - For calendar reform

      ## Conclusion

      The medieval period, far from being a "dark age" of science, was a time of careful observation, methodical study, and gradual development of the principles that would later flourish during the Renaissance and beyond.
    MARKDOWN
  end

  def rich_markdown_sample
    <<~MARKDOWN
      # Advanced Markdown Features

      This passage demonstrates various **markdown formatting** options to test the component's rendering capabilities.

      ## Text Formatting

      Here we have *italic text*, **bold text**, and even ***bold italic text***. We can also use `inline code` for technical terms.

      ## Lists and Structure

      ### Unordered List
      - First item with **bold text**
      - Second item with *italic text*
      - Third item with `inline code`

      ### Ordered List
      1. Primary point
      2. Secondary point with [a link](https://example.com)
      3. Tertiary point

      ## Quotations

      > "The only way to do great work is to love what you do." - Steve Jobs

      This quote demonstrates how blockquotes render within the reading passage component.

      ## Technical Content

      Sometimes reading passages include technical information that requires specific formatting for clarity and comprehension.
    MARKDOWN
  end

  def list_content_sample
    <<~MARKDOWN
      # Study Guide: European History

      ## Important Events

      ### Major Wars
      1. **The Hundred Years' War** (1337-1453)
         - Fought between England and France
         - Significant battles: Agincourt, Orleans
         - Impact on feudalism

      2. **The War of the Roses** (1455-1487)
         - Civil war in England
         - House of Lancaster vs. House of York
         - Led to Tudor dynasty

      ### Cultural Developments
      - Renaissance art movements
      - Scientific revolution
      - Religious reformation
      - Exploration and discovery

      ## Key Concepts to Remember

      - Political structures evolved from feudalism to nation-states
      - Trade networks expanded globally
      - Religious authority was challenged
      - Technology advanced rapidly
    MARKDOWN
  end

  def blockquote_content_sample
    <<~MARKDOWN
      # Philosophy and Critical Thinking

      Throughout history, great thinkers have offered wisdom that continues to guide us today. Consider these reflections on the nature of knowledge and learning:

      > "I know that I know nothing." - Socrates

      This famous paradox highlights the importance of intellectual humility. The more we learn, the more we realize how much we don't know.

      > "The unexamined life is not worth living." - Socrates

      Critical self-reflection is essential for personal growth and understanding. We must constantly question our assumptions and beliefs.

      ## The Value of Questions

      Rather than simply accepting information, we should ask:

      - What evidence supports this claim?
      - What assumptions am I making?
      - Are there alternative explanations?

      > "Education is not the filling of a pail, but the lighting of a fire." - W.B. Yeats

      True learning ignites curiosity and inspires further investigation rather than merely transferring facts from teacher to student.
    MARKDOWN
  end

  def sample_image
    "placeholder.png"
  end
end 