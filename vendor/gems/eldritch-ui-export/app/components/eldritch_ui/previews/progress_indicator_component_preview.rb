# frozen_string_literal: true

module EldritchUi
  class ProgressIndicatorComponentPreview < ViewComponent::Preview
    # @label Not Started (0% - current_step: 0 means "not started")
    # current_step: 0 indicates no work has begun yet (0% progress)
    def default
      render EldritchUi::ProgressIndicatorComponent.new(
        steps: ["Passage & Questions", "Image", "Formatting"],
        current_step: 0
      )
    end

    # @label One Step Complete (33% - current_step: 1)
    # current_step: 1 means step 0 is complete, working on step 1
    def one_step_done
      render EldritchUi::ProgressIndicatorComponent.new(
        steps: ["Passage & Questions", "Image", "Formatting"],
        current_step: 1
      )
    end

    # @label Fully Complete (100% - completed: true)
    # Using completed: true ensures 100% regardless of current_step
    def completed
      render EldritchUi::ProgressIndicatorComponent.new(
        steps: ["Passage & Questions", "Image", "Formatting"],
        current_step: 2,
        completed: true
      )
    end
  end
end
