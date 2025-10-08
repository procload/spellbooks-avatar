# frozen_string_literal: true

module EldritchUi
  class ProgressIndicatorComponent < ViewComponent::Base
    # @param steps [Array<String, Hash>] Array of step labels or step hashes with :label key
    # @param current_step [Integer] Zero-based index of current step (0 = first step in progress)
    # @param completed [Boolean] Whether all steps are completed
    # @param html_attributes [Hash] Additional HTML attributes
    def initialize(
      steps: [],
      current_step: 0,
      completed: false,
      **html_attributes
    )
      @steps = normalize_steps(steps)
      @current_step = current_step.to_i
      # Auto-complete when current_step reaches or exceeds total steps
      @completed = completed || (@current_step >= @steps.length && @steps.length > 0)
      @html_attributes = html_attributes
    end

    private

    attr_reader :steps, :current_step, :completed, :html_attributes

    def normalize_steps(raw_steps)
      return [] if raw_steps.blank?

      raw_steps.map do |step|
        if step.is_a?(Hash)
          step[:label] || step["label"] || step[:title] || step["title"] || "Step"
        else
          step.to_s
        end
      end
    end

    def progress_percentage
      return 100 if completed
      return 0 if steps.empty? || current_step <= 0

      # Calculate percentage based on completed steps
      # current_step represents the step INDEX currently being worked on (0-based)
      # Progress fills based on steps BEFORE the current step
      # If current_step is 0, 0% (nothing done yet)
      # If current_step is 1, 33% (step 0 done, working on step 1)
      # If current_step is 2, 66% (steps 0-1 done, working on step 2)
      step_size = 100.0 / steps.length
      [(current_step * step_size), 100].min
    end

    def component_attributes
      attrs = html_attributes.dup
      combined_classes = [default_css_classes, attrs.delete(:class)].compact.join(" ")

      {
        class: combined_classes,
        "data-controller": "eldritch-ui--progress-indicator",
        "data-eldritch-ui--progress-indicator-current-step-value": current_step,
        "data-eldritch-ui--progress-indicator-total-steps-value": steps.length,
        "data-eldritch-ui--progress-indicator-completed-value": completed,
        **attrs
      }
    end

    def default_css_classes
      classes = ["eld-progress-indicator"]
      classes << "eld-progress-indicator--completed" if completed
      classes.join(" ")
    end

    def step_progress_state(index)
      return "completed" if completed
      # current_step represents the step INDEX currently being worked on (0-based)
      #
      # IMPORTANT: current_step: 0 means "not started" (0% progress, all steps pending)
      # This is intentional - progress fills BEFORE the current step, not including it
      #
      # Examples:
      # - current_step: 0 → 0% progress, all steps pending (nothing started)
      # - current_step: 1 → 33% progress, step 0 completed, step 1 is current
      # - current_step: 2 → 66% progress, steps 0-1 completed, step 2 is current
      return "pending" if current_step == 0
      return "completed" if index < current_step
      return "current" if index == current_step
      "pending"
    end
  end
end
