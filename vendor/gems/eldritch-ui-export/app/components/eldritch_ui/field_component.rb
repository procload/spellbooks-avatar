# frozen_string_literal: true

class EldritchUi::FieldComponent < ViewComponent::Base
  renders_one :label
  renders_one :input
  renders_one :message

  def initialize(
    status: nil,
    message: nil,
    required: false,
    **html_attributes
  )
    @status = status&.to_sym
    @message = message
    @required = required
    @html_attributes = html_attributes
  end

  private

  attr_reader :status, :message, :required, :html_attributes

  def container_attributes
    attrs = html_attributes.dup
    custom_class = attrs.delete(:class)

    base_attrs = {
      class: [ container_css_classes, custom_class ].compact.join(" "),
      **attrs
    }

    # Add ARIA attributes for accessibility
    base_attrs[:"aria-invalid"] = "true" if status == :error
    base_attrs
  end

  def container_css_classes
    classes = [ "eld-field" ]
    classes << "eld-field--#{status}" if status.present?
    classes << "eld-field--required" if required
    classes.join(" ")
  end

  def message_css_classes
    classes = [ "eld-field__message" ]
    classes << "eld-field__message--#{status}" if status.present?
    classes.join(" ")
  end

  def show_message?
    message? || @message.present?
  end

  def message_slot?
    message?
  end

  def message_id
    @message_id ||= "field-message-#{SecureRandom.hex(4)}"
  end

  def input_id
    @input_id ||= "field-input-#{SecureRandom.hex(4)}"
  end

  # Helper methods for setting status
  def error?
    status == :error
  end

  def success?
    status == :success
  end

  def warning?
    status == :warning
  end

  def info?
    status == :info
  end
end
