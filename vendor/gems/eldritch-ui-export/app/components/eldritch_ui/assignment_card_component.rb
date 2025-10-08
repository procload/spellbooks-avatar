# frozen_string_literal: true

class EldritchUi::AssignmentCardComponent < ViewComponent::Base
  def initialize(title:, subject:, grade:, difficulty:, question_count:, tags: [], **html_attributes)
    @title = title
    @subject = subject
    @grade = grade
    @difficulty = difficulty
    @question_count = question_count
    @tags = tags.is_a?(Array) ? tags : tags.to_s.split(",").map(&:strip)
    @html_attributes = html_attributes
  end

  renders_one :image
  renders_one :actions

  private

  attr_reader :title, :subject, :grade, :difficulty, :question_count, :tags, :html_attributes

  def wrapper_attributes
    # Create a copy to avoid modifying the original
    attrs = html_attributes.dup

    # Extract and handle special attributes
    custom_class = attrs.delete(:class)

    # Merge component classes with any custom classes
    combined_classes = [ wrapper_css_classes, custom_class ].compact.join(" ")

    {
      class: combined_classes,
      **attrs
    }
  end

  def wrapper_css_classes
    base_classes = [ "eld-assignment-card", "eld-texture-parchment" ]
    subject_classes = subject_color_classes

    (base_classes + subject_classes).join(" ")
  end

  def subject_color_classes
    case subject&.downcase
    when "math"
      [ "eld-assignment-card--math" ]
    when "science"
      [ "eld-assignment-card--science" ]
    when "english"
      [ "eld-assignment-card--english" ]
    when "history"
      [ "eld-assignment-card--history" ]
    when "art"
      [ "eld-assignment-card--art" ]
    else
      [ "eld-assignment-card--default" ]
    end
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
end
