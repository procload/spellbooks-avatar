# frozen_string_literal: true

module EldritchUi
  # Token input component for adding/removing multiple values (simplified - no autocomplete)
  class TokenInputComponent < ViewComponent::Base
    attr_reader :name, :value, :tokens, :placeholder, :disabled, :readonly, :required,
                :label, :description, :error_message, :separator, :allow_duplicates,
                :case_sensitive, :standalone, :html_attributes

    def initialize(
      name:,
      value: nil,
      tokens: nil,
      placeholder: "Add interests (press Enter to add)",
      disabled: false,
      readonly: false,
      required: false,
      label: nil,
      description: nil,
      error_message: nil,
      separator: ",",
      allow_duplicates: false,
      case_sensitive: false,
      standalone: false,
      css_class: nil,
      **html_attributes
    )
      @name = name
      @value = value
      @separator = separator
      @tokens = parse_tokens(tokens || value)
      @placeholder = placeholder
      @disabled = disabled
      @readonly = readonly
      @required = required
      @label = label
      @description = description
      @error_message = error_message
      @allow_duplicates = allow_duplicates
      @case_sensitive = case_sensitive
      @standalone = standalone
      @html_attributes = html_attributes

      # Handle CSS classes
      css_classes = []

      if has_label?
        css_classes << "eld-attached-field"
        css_classes << "eld-attached-field--standalone" if @standalone
        css_classes << "eld-attached-field--disabled" if @disabled
        css_classes << "eld-attached-field--error" if @error_message.present?
      else
        css_classes << "eld-token-input"
        css_classes << "eld-token-input--disabled" if @disabled
        css_classes << "eld-token-input--readonly" if @readonly
        css_classes << "eld-token-input--error" if @error_message.present?
        css_classes << "eld-token-input--required" if @required
      end

      css_classes << css_class if css_class.present?

      @html_attributes[:class] = css_classes.compact.join(" ")

      # Add Stimulus controller
      existing_controller = @html_attributes[:"data-controller"]
      new_controller = existing_controller.present? ?
        "#{existing_controller} eldritch-ui--token-input" :
        "eldritch-ui--token-input"
      @html_attributes[:"data-controller"] = new_controller.to_s

      # Add Stimulus values (simplified - removed suggestions-related values)
      @html_attributes[:"data-eldritch-ui--token-input-separator-value"] = separator
      @html_attributes[:"data-eldritch-ui--token-input-allow-duplicates-value"] = allow_duplicates
      @html_attributes[:"data-eldritch-ui--token-input-case-sensitive-value"] = case_sensitive
    end

    private

    def has_label?
      label.present?
    end

    def has_description?
      description.present?
    end

    def has_error?
      error_message.present?
    end

    def label_css_classes
      classes = [ "eld-attached-field__label" ]
      classes << "eld-attached-field__label--required" if required
      classes.join(" ")
    end

    def control_wrapper_css_classes
      classes = [ "eld-attached-field__wrapper" ]
      classes.join(" ")
    end

    def token_input_css_classes
      classes = [ "eld-token-input" ]
      classes << "eld-token-input--disabled" if disabled
      classes << "eld-token-input--readonly" if readonly
      classes << "eld-token-input--error" if error_message.present?
      classes << "eld-token-input--required" if required
      classes.compact.join(" ")
    end

    def parse_tokens(input)
      return [] if input.blank?

      if input.is_a?(Array)
        input.map(&:to_s).map(&:strip).reject(&:blank?)
      else
        input.to_s.split(separator).map(&:strip).reject(&:blank?)
      end
    end

    def tokens_value
      tokens.join(separator)
    end

    def container_id
      @container_id ||= html_attributes[:id] || "token_input_#{name}_#{SecureRandom.hex(4)}"
    end

    def input_id
      "#{container_id}_input"
    end

    def hidden_input_id
      "#{container_id}_hidden"
    end

    def label_id
      "#{container_id}_label" if label.present?
    end

    def description_id
      "#{container_id}_description" if description.present?
    end

    def error_id
      "#{container_id}_error" if error_message.present?
    end

    def input_attributes
      attrs = {
        id: input_id,
        type: "text",
        class: "eld-token-input__field",
        placeholder: placeholder,
        autocomplete: "off",
        "data-eldritch-ui--token-input-target": "input",
        "data-action": "keydown->eldritch-ui--token-input#handleKeydown focus->eldritch-ui--token-input#handleFocus blur->eldritch-ui--token-input#handleBlur"
      }

      attrs[:disabled] = true if disabled
      attrs[:readonly] = true if readonly
      attrs[:required] = true if required
      attrs[:"aria-invalid"] = "true" if error_message.present?
      attrs[:"aria-labelledby"] = label_id if label_id
      attrs[:"aria-describedby"] = aria_describedby if has_description? || has_error?

      attrs
    end

    def hidden_input_attributes
      {
        id: hidden_input_id,
        name: name,
        type: "hidden",
        value: tokens_value,
        "data-eldritch-ui--token-input-target": "hiddenInput"
      }
    end

    def label_attributes
      {
        id: label_id,
        for: input_id,
        class: label_css_classes
      }
    end

    def container_attributes
      attrs = html_attributes.dup
      attrs[:id] = container_id
      attrs
    end

    def field_id
      @field_id ||= name.present? ? name.to_s.gsub(/\W/, "_") : "token_input_#{object_id}"
    end

    def aria_describedby
      ids = []
      ids << description_id if has_description?
      ids << error_id if has_error?
      ids.any? ? ids.join(" ") : nil
    end
  end
end
