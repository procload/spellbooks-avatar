# frozen_string_literal: true

module EldritchUi
  # @label Token Input
  class TokenInputComponentPreview < ViewComponent::Preview
    # @label Interactive Playground
    # @param name text "Form field name"
    # @param value text "Initial comma-separated tokens"
    # @param placeholder text "Placeholder text"
    # @param label text "Field label"
    # @param description text "Help text"
    # @param error_message text "Error message"
    # @param separator select { choices: [",", ";", "|"] } "Token separator"
    # @param disabled toggle "Disabled state"
    # @param readonly toggle "Read-only state"
    # @param required toggle "Required field"
    # @param allow_duplicates toggle "Allow duplicate tokens"
    # @param case_sensitive toggle "Case sensitive matching"
    def playground(
      name: "tokens",
      value: "javascript, python, react",
      placeholder: "Add items (press Enter to add)",
      label: "Programming Skills",
      description: "Enter your programming skills and technologies",
      error_message: nil,
      separator: ",",
      disabled: false,
      readonly: false,
      required: false,
      allow_duplicates: false,
      case_sensitive: false
    )
      render EldritchUi::TokenInputComponent.new(
        name: name,
        value: value,
        placeholder: placeholder,
        label: label,
        description: description,
        error_message: error_message,
        separator: separator,
        disabled: disabled,
        readonly: readonly,
        required: required,
        allow_duplicates: allow_duplicates,
        case_sensitive: case_sensitive
      )
    end

    # @label Interests (Figma Design)
    def interests_figma_design
      render EldritchUi::TokenInputComponent.new(
        name: "interests",
        value: "Pokemon, Pokemon, Pokemon, Pokemon, Pokemon",
        label: "INTERESTS",
        placeholder: "Add interests (press Enter to add)"
      )
    end

    # @label Default
    def default
      render EldritchUi::TokenInputComponent.new(
        name: "skills",
        label: "Skills",
        placeholder: "Add your skills..."
      )
    end

    # @label With Initial Tokens
    def with_initial_tokens
      render EldritchUi::TokenInputComponent.new(
        name: "technologies",
        value: "Ruby, Rails, JavaScript, React, PostgreSQL",
        label: "Technologies",
        description: "Technologies you're experienced with"
      )
    end

    # @label Empty State
    def empty_state
      render EldritchUi::TokenInputComponent.new(
        name: "empty",
        label: "Empty Token Input",
        placeholder: "Start typing to add tokens..."
      )
    end

    # @label Required
    def required
      render EldritchUi::TokenInputComponent.new(
        name: "required_field",
        label: "Required Field",
        placeholder: "This field is required...",
        required: true
      )
    end

    # @label With Error
    def with_error
      render EldritchUi::TokenInputComponent.new(
        name: "error_field",
        label: "Field with Error",
        placeholder: "This field has an error...",
        error_message: "Please add at least one item"
      )
    end

    # @label Disabled
    def disabled
      render EldritchUi::TokenInputComponent.new(
        name: "disabled_field",
        value: "Item 1, Item 2, Item 3",
        label: "Disabled Field",
        disabled: true
      )
    end

    # @label Read-only
    def readonly
      render EldritchUi::TokenInputComponent.new(
        name: "readonly_field",
        value: "Item 1, Item 2, Item 3",
        label: "Read-only Field",
        readonly: true
      )
    end

    # @label Custom Separator
    def custom_separator
      render EldritchUi::TokenInputComponent.new(
        name: "custom_sep",
        value: "Item 1; Item 2; Item 3",
        label: "Semicolon Separated",
        separator: ";",
        placeholder: "Add items (separate with semicolons)..."
      )
    end

    # @label Allow Duplicates
    def allow_duplicates
      render EldritchUi::TokenInputComponent.new(
        name: "duplicates",
        value: "Item 1, Item 1, Item 2",
        label: "Allow Duplicates",
        allow_duplicates: true,
        placeholder: "Duplicates are allowed..."
      )
    end

    # @label Case Sensitive
    def case_sensitive
      render EldritchUi::TokenInputComponent.new(
        name: "case_sensitive",
        value: "Item, item, ITEM",
        label: "Case Sensitive",
        case_sensitive: true,
        placeholder: "Case matters here..."
      )
    end

    # @label Form Integration
    def form_integration
      render_inline <<~ERB
        <div style="max-width: 600px; margin: 0 auto; padding: 2rem;">
          <form style="background: var(--eldritch-color-surface); padding: 2rem; border-radius: var(--eldritch-border-radius-medium); border: var(--eldritch-border-width-thin) solid var(--eldritch-color-default-border);">
            <h3 style="margin-bottom: 1.5rem; color: var(--eldritch-color-text-on-background); font-family: var(--eldritch-font-family-rubik);">Profile Information</h3>
            
            <%= render EldritchUi::TokenInputComponent.new(
              name: "skills",
              value: "Ruby, JavaScript, Design",
              label: "Skills",
              description: "Add your professional skills",
              placeholder: "Type and press Enter..."
            ) %>
            
            <div style="margin-top: 1.5rem;">
              <%= render EldritchUi::TokenInputComponent.new(
                name: "interests",
                value: "Hiking, Photography, Cooking",
                label: "Personal Interests",
                description: "Share your hobbies and interests",
                placeholder: "What do you enjoy doing?"
              ) %>
            </div>
            
            <div style="margin-top: 2rem; display: flex; gap: 1rem;">
              <button type="submit" style="background: var(--eldritch-color-primary); color: var(--eldritch-color-text-on-primary); border: none; padding: 0.75rem 1.5rem; border-radius: var(--eldritch-border-radius-small); cursor: pointer;">Save Profile</button>
              <button type="reset" style="background: var(--eldritch-color-surface); color: var(--eldritch-color-text-on-surface); border: var(--eldritch-border-width-thin) solid var(--eldritch-color-default-border); padding: 0.75rem 1.5rem; border-radius: var(--eldritch-border-radius-small); cursor: pointer;">Reset</button>
            </div>
          </form>
        </div>
      ERB
    end

    # @label Attached Field - Basic
    # @!group Attached Field Examples
    def attached_field_basic
      render EldritchUi::TokenInputComponent.new(
        name: "interests",
        label: "Interests",
        value: "Pokemon, Dragons, Magic",
        placeholder: "Add interests (press Enter to add)"
      )
    end

    # @label Attached Field - With Description
    # @!group Attached Field Examples
    def attached_field_with_description
      render EldritchUi::TokenInputComponent.new(
        name: "skills",
        label: "Skills",
        description: "Add your professional skills and technologies",
        value: "Ruby, JavaScript, PostgreSQL",
        placeholder: "Type skills and press Enter..."
      )
    end

    # @label Attached Field - With Error
    # @!group Attached Field Examples
    def attached_field_with_error
      render EldritchUi::TokenInputComponent.new(
        name: "required_skills",
        label: "Required Skills",
        error_message: "Please add at least 3 skills",
        placeholder: "Add your skills..."
      )
    end

    # @label Standalone Mode
    # @!group Attached Field Examples
    def standalone_mode
      render EldritchUi::TokenInputComponent.new(
        name: "tags",
        label: "Tags",
        standalone: true,
        value: "tag1, tag2, tag3",
        placeholder: "Add tags..."
      )
    end

    private

    def render_inline(template)
      ApplicationController.render(inline: template, type: :erb, locals: {})
    end
  end
end 