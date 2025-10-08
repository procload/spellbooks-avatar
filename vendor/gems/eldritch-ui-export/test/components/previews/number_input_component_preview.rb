# frozen_string_literal: true

module EldritchUi
  # @label Number Input
  class NumberInputComponentPreview < ViewComponent::Preview
    # @label Default
    def default
      render EldritchUi::NumberInputComponent.new(name: "quantity")
    end

    # @label With Value
    def with_value
      render EldritchUi::NumberInputComponent.new(name: "quantity", value: 5)
    end

    # @label With Placeholder
    def with_placeholder
      render EldritchUi::NumberInputComponent.new(
        name: "quantity", 
        placeholder: "Enter quantity"
      )
    end

    # @label With Min, Max, Step
    def with_constraints
      render EldritchUi::NumberInputComponent.new(
        name: "quantity", 
        min: 1, 
        max: 100, 
        step: 5,
        value: 10
      )
    end

    # @label Required
    def required
      render EldritchUi::NumberInputComponent.new(
        name: "quantity", 
        required: true,
        placeholder: "Required field"
      )
    end

    # @label Disabled
    def disabled
      render EldritchUi::NumberInputComponent.new(
        name: "quantity", 
        disabled: true,
        value: 42
      )
    end

    # @label Readonly
    def readonly
      render EldritchUi::NumberInputComponent.new(
        name: "quantity", 
        readonly: true,
        value: 42
      )
    end

    # @label With Custom Classes
    def with_custom_classes
      render EldritchUi::NumberInputComponent.new(
        name: "quantity",
        class: "w-32",
        placeholder: "Custom width"
      )
    end

    # @label Currency Input Example
    def currency_example
      render EldritchUi::NumberInputComponent.new(
        name: "price",
        min: 0,
        step: 0.01,
        placeholder: "0.00",
        "aria-label": "Price in USD"
      )
    end

    # @label Age Input Example
    def age_example
      render EldritchUi::NumberInputComponent.new(
        name: "age",
        min: 0,
        max: 120,
        step: 1,
        placeholder: "Enter your age"
      )
    end

    # @label Percentage Input Example
    def percentage_example
      render EldritchUi::NumberInputComponent.new(
        name: "completion",
        min: 0,
        max: 100,
        step: 1,
        placeholder: "0-100%"
      )
    end

    # @label With Data Attributes
    def with_data_attributes
      render EldritchUi::NumberInputComponent.new(
        name: "quantity",
        data: {
          testid: "quantity-input",
          controller: "calculation",
          action: "input->calculation#update"
        }
      )
    end
  end
end