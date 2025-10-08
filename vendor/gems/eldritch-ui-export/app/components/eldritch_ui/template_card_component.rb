# frozen_string_literal: true

module EldritchUi
  class TemplateCardComponent < ViewComponent::Base
    def initialize(
      title:,
      subject:,
      grade:,
      questions:,
      difficulty: "Medium",
      interests: [],
      icon: nil,
      show_icon: false,
      **html_attributes
    )
      @title = title
      @subject = subject
      @grade = grade
      @questions = questions
      @difficulty = difficulty
      @interests = interests
      @icon = icon
      @show_icon = show_icon
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :title, :subject, :grade, :questions, :difficulty, :interests, :icon, :show_icon, :html_attributes

    def card_attributes
      base_attrs = {
        "data-controller": "template-card",
        "data-template-subject": subject,
        "data-template-grade": grade,
        "data-template-questions": questions,
        "data-template-difficulty": difficulty,
        "data-template-interests": interests.join(","),
        "data-template-title": title,
        "data-action": "template-card#useTemplate"
      }

      attrs = html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split

      attrs.merge!(base_attrs)
      attrs[:class] = (default_css_classes.split + custom_classes).uniq.join(" ")

      attrs.compact
    end

    def default_css_classes
      "eld-template-card"
    end

    def template_icon
      @template_icon ||= icon || icon_for_subject
    end

    def icon_for_subject
      case subject.downcase
      when "math"
        "calculator"
      when "science"
        "beaker"
      when "english"
        "book-open"
      when "history"
        "building-library"
      when "art"
        "paint-brush"
      else
        "document-text"
      end
    end

    def grade_display
      case grade.to_i
      when 0
        "Kindergarten"
      when 1..12
        "Grade #{grade}"
      else
        grade
      end
    end

    def template_summary
      parts = []
      parts << questions_text
      parts << difficulty if difficulty.present?

      parts.join(" • ")
    end

    def questions_text
      case questions.to_i
      when 1
        "1 question"
      else
        "#{questions} questions"
      end
    end

    def has_interests?
      interests.any?
    end

    def interests_display
      return nil unless has_interests?

      interests.first(3).join(", ") + (interests.length > 3 ? "..." : "")
    end
  end
end
