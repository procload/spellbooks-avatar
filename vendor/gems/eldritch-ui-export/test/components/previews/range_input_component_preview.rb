# frozen_string_literal: true

module EldritchUi
  # @label Range Input
  class RangeInputComponentPreview < ViewComponent::Preview
    # @label Default
    def default
      render EldritchUi::RangeInputComponent.new(name: "volume")
    end

    # @label With Value
    def with_value
      render EldritchUi::RangeInputComponent.new(name: "volume", value: 75)
    end

    # @label Custom Range
    def custom_range
      render EldritchUi::RangeInputComponent.new(
        name: "temperature", 
        min: -10, 
        max: 40, 
        step: 2,
        value: 20
      )
    end

    # @label Decimal Steps
    def decimal_steps
      render EldritchUi::RangeInputComponent.new(
        name: "opacity", 
        min: 0, 
        max: 1, 
        step: 0.1,
        value: 0.5
      )
    end

    # @label Without Value Display
    def without_value_display
      render EldritchUi::RangeInputComponent.new(
        name: "volume", 
        show_value: false,
        value: 60
      )
    end

    # @label Required
    def required
      render EldritchUi::RangeInputComponent.new(
        name: "volume", 
        required: true,
        value: 50
      )
    end

    # @label Disabled
    def disabled
      render EldritchUi::RangeInputComponent.new(
        name: "volume", 
        disabled: true,
        value: 30
      )
    end

    # @label Volume Control Example
    def volume_control
      render EldritchUi::RangeInputComponent.new(
        name: "audio_volume",
        min: 0,
        max: 100,
        step: 5,
        value: 65,
        "aria-label": "Audio volume control"
      )
    end

    # @label Progress/Completion Example
    def progress_example
      render EldritchUi::RangeInputComponent.new(
        name: "completion",
        min: 0,
        max: 100,
        step: 1,
        value: 85,
        "aria-label": "Task completion percentage"
      )
    end

    # @label Rating Example
    def rating_example
      render EldritchUi::RangeInputComponent.new(
        name: "rating",
        min: 1,
        max: 5,
        step: 1,
        value: 4,
        "aria-label": "Rate from 1 to 5 stars"
      )
    end

    # @label With Data Attributes
    def with_data_attributes
      render EldritchUi::RangeInputComponent.new(
        name: "brightness",
        min: 0,
        max: 100,
        value: 75,
        data: {
          testid: "brightness-slider",
          controller: "theme-brightness",
          action: "input->theme-brightness#adjustBrightness"
        }
      )
    end

    # @label Large Range Example
    def large_range
      render EldritchUi::RangeInputComponent.new(
        name: "year",
        min: 1900,
        max: 2030,
        step: 1,
        value: 2024,
        "aria-label": "Select year"
      )
    end
  end
end