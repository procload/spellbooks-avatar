# frozen_string_literal: true

module EldritchUi
  # Textarea component for multi-line text input with validation and accessibility
  class TextareaComponent < ViewComponent::Base
    attr_reader :name, :value, :placeholder, :rows, :cols, :disabled, :readonly, :required, :label, :description, :error_message, :size, :variant, :resize, :standalone, :html_attributes

    def initialize(
      name:,
      value: nil,
      placeholder: nil,
      rows: 4,
      cols: nil,
      disabled: false,
      readonly: false,
      required: false,
      label: nil,
      description: nil,
      error_message: nil,
      size: :default,
      variant: :default,
      resize: :vertical,
      standalone: false,
      css_class: nil,
      **html_attributes
    )
      @name = name
      @value = value
      @placeholder = placeholder
      @rows = rows
      @cols = cols
      @disabled = disabled
      @readonly = readonly
      @required = required
      @label = label
      @description = description
      @error_message = error_message
      @size = size.to_sym
      @variant = variant.to_sym
      @resize = resize.to_sym
      @standalone = standalone
      @html_attributes = html_attributes

      # Handle CSS classes (align with attached field pattern used by inputs/selects)
      @html_attributes[:class] = class_names(
        "eld-attached-field",               # shared attached label pattern
        "eld-textarea",                     # textarea-specific hook
        "eld-attached-field--#{@size}" => @size != :default,
        "eld-attached-field--#{@variant}" => @variant != :default,
        "eld-attached-field--standalone" => @standalone,
        "eld-attached-field--disabled" => @disabled,
        "eld-attached-field--readonly" => @readonly,
        "eld-attached-field--error" => @error_message.present?,
        "eld-attached-field--required" => @required,
        # keep resize hook for field styling
        "eld-textarea--#{@resize}" => @resize != :vertical,
        css_class => css_class.present?
      )
    end

    private

    def textarea_id
      @textarea_id ||= html_attributes[:id] || "textarea_#{name}_#{SecureRandom.hex(4)}"
    end

    def label_id
      "#{textarea_id}_label" if label.present?
    end

    def description_id
      "#{textarea_id}_description" if description.present?
    end

    def error_id
      "#{textarea_id}_error" if error_message.present?
    end

    def textarea_attributes
      attrs = {
        id: textarea_id,
        name: name,
        rows: rows,
        class: textarea_css_classes
      }

      attrs[:cols] = cols if cols.present?
      attrs[:placeholder] = placeholder if placeholder.present?
      attrs[:disabled] = true if disabled
      attrs[:readonly] = true if readonly
      attrs[:required] = true if required
      attrs[:"aria-invalid"] = "true" if error_message.present?
      attrs[:"aria-labelledby"] = label_id if label_id
      attrs[:"aria-describedby"] = [ description_id, error_id ].compact.join(" ") if description_id || error_id

      attrs.merge(html_attributes.except(:class, :id))
    end

    def textarea_css_classes
      class_names(
        "eld-textarea__field",
        "eld-textarea__field--resize-#{resize}"
      )
    end

    def label_attributes
      {
        id: label_id,
        for: textarea_id,
        class: "eld-attached-field__label"
      }
    end

    def valid_resize_options
      %i[none both horizontal vertical]
    end

    def resize
      valid_resize_options.include?(@resize) ? @resize : :vertical
    end
  end
end
