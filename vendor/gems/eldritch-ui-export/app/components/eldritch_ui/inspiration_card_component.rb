# frozen_string_literal: true

module EldritchUi
  class InspirationCardComponent < ViewComponent::Base
    def initialize(title:, subtitle: nil, tags: [], students_count: nil, icon_name: nil,
                   template_key: nil, href: nil, **html_attributes)
      @title = title
      @subtitle = subtitle
      @tags = normalize_tags(tags)
      @students_count = students_count
      @icon_name = icon_name
      @template_key = template_key
      @href = href
      @html_attributes = html_attributes.freeze
    end

    renders_one :action, types: {
      template: ->(template_key:, size: :small, label: "Use Template", **button_options) {
        EldritchUi::ButtonComponent.new(
          label: label,
          size: size,
          data: {
            action: "click->template-params#applyTemplateFromButton",
            "template-key": template_key
          },
          **button_options
        )
      },
      link: ->(href:, size: :small, label: "Use Template", **button_options) {
        EldritchUi::ButtonComponent.new(
          label: label,
          size: size,
          onclick: "window.location.href='#{href}'",
          **button_options
        )
      }
    }

    private

    attr_reader :title, :subtitle, :tags, :students_count, :icon_name, :template_key, :href

    def component_tag_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?
      attrs
    end

    def default_css_classes
      "eld-inspiration-card"
    end

    def has_tags?
      tags.present? && tags.any?
    end

    def has_icon?
      icon_name.present?
    end

    def has_students_count?
      students_count.present? && students_count.to_i > 0
    end

    def has_action?
      action.present? || template_key.present? || href.present?
    end

    def formatted_students_count
      return nil unless has_students_count?
      students_count.to_i
    end

    def formatted_subtitle
      subtitle.to_s.strip if subtitle.present?
    end

    def default_action_button
      return nil unless template_key.present? || href.present?

      if template_key.present?
        EldritchUi::ButtonComponent.new(
          label: "Use Template",
          size: :small,
          data: {
            action: "click->template-params#applyTemplateFromButton",
            "template-key": template_key
          }
        )
      elsif href.present?
        EldritchUi::ButtonComponent.new(
          label: "Use Template",
          size: :small,
          onclick: "window.location.href='#{href}'"
        )
      end
    end

    private

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
  end
end
