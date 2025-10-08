# frozen_string_literal: true

module EldritchUi
  class AssignmentItemComponent < ViewComponent::Base
    VALID_SIZES = [ :default, :compact ].freeze

    def initialize(
      title: nil,
      subject: nil,
      grade: nil,
      difficulty: nil,
      question_count: nil,
      tags: [],
      href: nil,
      clickable: false,
      size: :default,
      assignment: nil,
      progress: nil,
      **html_attributes
    )
      # Support legacy assignment object + progress pattern
      if assignment.present?
        @title = assignment.title
        @subject = assignment.subject if assignment.respond_to?(:subject)
        @grade = assignment.grade if assignment.respond_to?(:grade)
        @difficulty = assignment.difficulty if assignment.respond_to?(:difficulty)
        @question_count = assignment.question_count if assignment.respond_to?(:question_count)
        @tags = assignment.respond_to?(:tags) ? normalize_tags(assignment.tags) : []
        @progress = progress
        @assignment = assignment
      else
        # Support new explicit parameters pattern
        @title = title
        @subject = subject
        @grade = grade
        @difficulty = difficulty
        @question_count = question_count
        @tags = normalize_tags(tags)
        @progress = progress
        @assignment = nil
      end

      @href = href
      @clickable = clickable || href.present?
      @size = validate_size(size)
      @html_attributes = html_attributes.freeze
    end

    renders_one :icon
    renders_one :actions

    private

    attr_reader :title, :subject, :grade, :difficulty, :question_count, :tags, :href, :clickable, :size, :progress, :assignment

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")

      attrs[:class] = final_classes if final_classes.present?
      attrs[:role] = "button" if clickable? && !href.present?
      attrs[:tabindex] = "0" if clickable? && !href.present?
      attrs[:href] = href if href.present?

      attrs
    end

    def default_css_classes
      classes = [ "eld-assignment-item" ]
      classes << "eld-assignment-item--#{size}"
      classes << "eld-assignment-item--clickable" if clickable?
      classes << "eld-assignment-item--with-actions" if has_actions?
      classes.compact.join(" ")
    end

    def component_tag
      href.present? ? :a : :div
    end

    def question_count_text
      if question_count == 1
        "1 question"
      else
        "#{question_count} questions"
      end
    end

    def has_tags?
      tags.present? && tags.any?
    end

    def has_icon?
      icon.present?
    end

    def has_actions?
      actions.present?
    end

    def clickable?
      clickable
    end

    def normalize_tags(tags_input)
      return [] if tags_input.blank?

      case tags_input
      when Array
        tags_input.map(&:to_s).reject(&:blank?)
      when String
        tags_input.split(",").map(&:strip).reject(&:blank?)
      else
        [ tags_input.to_s ].reject(&:blank?)
      end
    end

    def validate_size(size_input)
      size_sym = size_input.to_sym
      unless VALID_SIZES.include?(size_sym)
        raise ArgumentError, "Invalid size: #{size_input}. Must be one of: #{VALID_SIZES.join(', ')}"
      end
      size_sym
    end

    def unique_id
      @unique_id ||= "assignment-item-#{SecureRandom.hex(4)}"
    end

    def metadata_items
      [ subject, grade, difficulty, question_count_text ].compact
    end

    def metadata_text
      metadata_items.join(" • ")
    end

    def has_progress?
      progress.present?
    end

    def progress_percentage
      return 0 unless progress.present?
      progress.to_i.clamp(0, 100)
    end

    def legacy_mode?
      assignment.present?
    end

    def simplified_metadata_text
      # For legacy mode, show simpler metadata
      return "" unless assignment.present?
      # Could show subject or other simple assignment info if available
      ""
    end
  end
end
