module EldritchUi
  class ReadingPassageComponent < ViewComponent::Base
    def initialize(passage_content:, title: nil, subject: nil, grade_level: nil, difficulty: nil,
                   interests: [], image: nil, image_position: :right, editable: false,
                   edit_button_text: "Edit passage", save_button_text: "Save changes",
                   title_actions: nil, print_url: nil, hide_edit_buttons: false, **html_attributes)
      @passage_content = passage_content
      @title = title
      @subject = subject
      @grade_level = grade_level
      @difficulty = difficulty
      @interests = Array(interests)
      @image = image
      @image_position = validate_image_position(image_position)
      @editable = editable
      @edit_button_text = edit_button_text
      @save_button_text = save_button_text
      @title_actions = title_actions
      @print_url = print_url
      @hide_edit_buttons = hide_edit_buttons
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :passage_content, :title, :subject, :grade_level, :difficulty, :interests, :image, :image_position, :editable, :edit_button_text, :save_button_text, :title_actions, :print_url, :hide_edit_buttons

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?
      attrs
    end

    def default_css_classes
      classes = [ "eld-reading-passage" ]
      classes << "eld-reading-passage--editable" if editable?
      classes << "eld-reading-passage--with-image" if has_image?
      classes.join(" ")
    end

    def container_attributes
      attrs = component_tag_attributes
      attrs[:role] = "article"
      attrs["aria-label"] = "Reading passage"
      attrs
    end

    def content_attributes
      {
        class: content_css_classes,
        "data-original-content": passage_content
      }
    end

    def content_css_classes
      classes = [ "eld-reading-passage__content" ]
      classes << "eld-reading-passage__content--with-image-#{image_position}" if has_image?
      classes.join(" ")
    end

    def image_css_classes
      classes = [ "eld-reading-passage__image" ]
      classes << "eld-reading-passage__image--#{image_position}"
      classes.join(" ")
    end

    def textarea_attributes
      {
        class: "eld-reading-passage__editor hidden",
        "data-markdown-editor-target": "editor"
      }
    end

    def has_image?
      image.present?
    end

    def has_title?
      title.present?
    end

    def editable?
      editable
    end

    def has_metadata?
      subject.present? || grade_level.present? || difficulty.present? || interests.any?
    end

    def metadata_tags
      tags = []
      tags << subject if subject.present?
      tags << "Grade #{grade_level}" if grade_level.present?
      tags << difficulty.titleize if difficulty.present?
      tags.concat(interests.map(&:to_s)) if interests.any?
      tags
    end

    def rendered_content
      return "" if passage_content.blank?

      # Use the existing markdown helper from the view context
      helpers.markdown(passage_content)
    end

    def validate_image_position(position)
      valid_positions = %i[left right top inline]
      return :right unless valid_positions.include?(position)
      position
    end

    def unique_id
      @unique_id ||= "reading_passage_#{SecureRandom.hex(4)}"
    end

    def has_title_actions?
      title_actions.present?
    end
  end
end
