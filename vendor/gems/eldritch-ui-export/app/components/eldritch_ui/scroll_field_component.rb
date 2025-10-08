# frozen_string_literal: true

module EldritchUi
  # Scroll Field Component - Parchment scroll design with label tab
  # Displays content in a distinctive aged parchment scroll with an attached label tab
  class ScrollFieldComponent < ViewComponent::Base
    attr_reader :label_text, :text, :name, :placeholder, :editable, :rows, :single_line, :type, :required, :disabled, :html_attributes

    def initialize(
      label_text:,
      text: nil,
      name: nil,
      placeholder: nil,
      editable: false,
      rows: 6,
      single_line: false,
      type: :text,
      required: false,
      disabled: false,
      **html_attributes
    )
      @label_text = label_text
      @text = text
      @name = name
      @placeholder = placeholder
      @editable = editable
      @rows = rows
      @single_line = single_line
      @type = type.to_s
      @required = required
      @disabled = disabled
      @html_attributes = html_attributes.freeze
    end

    private

    def container_attributes
      attrs = @html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = container_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")
      attrs[:class] = final_classes if final_classes.present?
      attrs
    end

    def container_css_classes
      "eld-scroll-field"
    end

    def scroll_id
      @scroll_id ||= html_attributes[:id] || "scroll_#{name || SecureRandom.hex(4)}"
    end

    def input_attributes
      return {} unless editable && single_line

      attrs = {
        id: "#{scroll_id}_input",
        name: name,
        type: type,
        value: text,
        class: "eld-scroll-field__input"
      }

      attrs[:placeholder] = placeholder if placeholder.present?
      attrs[:required] = true if required
      attrs[:disabled] = true if disabled
      attrs
    end

    def textarea_attributes
      return {} unless editable && !single_line

      attrs = {
        id: "#{scroll_id}_textarea",
        name: name,
        rows: rows,
        class: "eld-scroll-field__textarea"
      }

      attrs[:placeholder] = placeholder if placeholder.present?
      attrs[:required] = true if required
      attrs[:disabled] = true if disabled
      attrs
    end

    def content_id
      "#{scroll_id}_content"
    end
  end
end
