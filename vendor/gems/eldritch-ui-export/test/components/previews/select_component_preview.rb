# frozen_string_literal: true

class EldritchUi::SelectComponentPreview < ViewComponent::Preview
  # @label Interactive Playground
  # @param options text "JSON array of options"
  # @param value text "Selected value(s)"
  # @param name text "Form field name"
  # @param size select { choices: [small, default, large] } "Size variant"
  # @param multiple toggle "Allow multiple selections"
  # @param disabled toggle "Disable the select"
  # @param required toggle "Mark as required"
  # @param placeholder text "Placeholder text"
  # @param aria_label text "ARIA label"
  def playground(
    options: '[{"value":"us","label":"United States"},{"value":"ca","label":"Canada"},{"value":"uk","label":"United Kingdom"}]',
    value: "",
    name: "country",
    size: :default,
    multiple: false,
    disabled: false,
    required: false,
    placeholder: "Choose a country...",
    aria_label: ""
  )
    parsed_options = JSON.parse(options) rescue country_options
    
    render EldritchUi::SelectComponent.new(
      options: parsed_options,
      value: value,
      name: name,
      size: size.to_sym,
      multiple: multiple,
      disabled: disabled,
      required: required,
      placeholder: placeholder.presence,
      aria_label: aria_label.presence
    )
  end

  # @!group Basic Examples

  # @label Default Select
  def default
    render EldritchUi::SelectComponent.new(
      options: country_options,
      placeholder: "Choose a country...",
      name: "country"
    )
  end

  # @label With Selected Value
  def with_value
    render EldritchUi::SelectComponent.new(
      options: country_options,
      value: "ca",
      name: "country"
    )
  end

  # @label With Placeholder
  def with_placeholder
    render EldritchUi::SelectComponent.new(
      options: skill_options,
      placeholder: "Select your skills...",
      name: "skills"
    )
  end

  # @!endgroup

  # @!group Multiple Selection

  # @label Multiple Select
  def multiple
    render EldritchUi::SelectComponent.new(
      options: skill_options,
      multiple: true,
      name: "skills"
    )
  end

  # @label Multiple with Selected Values
  def multiple_with_values
    render EldritchUi::SelectComponent.new(
      options: skill_options,
      value: ["javascript", "ruby"],
      multiple: true,
      name: "skills"
    )
  end

  # @!endgroup

  # @!group Size Variants

  # @label Small Size
  def small
    render EldritchUi::SelectComponent.new(
      options: country_options,
      size: :small,
      placeholder: "Small select...",
      name: "country_small"
    )
  end

  # @label Large Size
  def large
    render EldritchUi::SelectComponent.new(
      options: country_options,
      size: :large,
      placeholder: "Large select...",
      name: "country_large"
    )
  end

  # @!endgroup

  # @!group States

  # @label Disabled Select
  def disabled
    render EldritchUi::SelectComponent.new(
      options: country_options,
      disabled: true,
      placeholder: "Disabled select...",
      name: "country_disabled"
    )
  end

  # @label Required Select
  def required
    render EldritchUi::SelectComponent.new(
      options: country_options,
      required: true,
      placeholder: "Required field...",
      name: "country_required"
    )
  end

  # @!endgroup

  # @!group Advanced

  # @label With Disabled Options
  def with_disabled_options
    options_with_disabled = [
      { value: "us", label: "United States" },
      { value: "ca", label: "Canada", disabled: true },
      { value: "uk", label: "United Kingdom" },
      { value: "de", label: "Germany", disabled: true },
      { value: "fr", label: "France" }
    ]
    
    render EldritchUi::SelectComponent.new(
      options: options_with_disabled,
      placeholder: "Some options disabled...",
      name: "country_disabled_options"
    )
  end

  # @label Form Integration
  def form_integration
    render_with_template(template: "eldritch_ui/select_component_preview/form_integration")
  end

  # @!endgroup

  private

  def country_options
    [
      { value: "us", label: "United States" },
      { value: "ca", label: "Canada" },
      { value: "uk", label: "United Kingdom" },
      { value: "de", label: "Germany" },
      { value: "fr", label: "France" },
      { value: "jp", label: "Japan" },
      { value: "au", label: "Australia" }
    ]
  end

  def skill_options
    [
      { value: "javascript", label: "JavaScript" },
      { value: "typescript", label: "TypeScript" },
      { value: "python", label: "Python" },
      { value: "ruby", label: "Ruby" },
      { value: "golang", label: "Go" },
      { value: "rust", label: "Rust" },
      { value: "java", label: "Java" }
    ]
  end
end 