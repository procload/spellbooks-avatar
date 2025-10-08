# frozen_string_literal: true

module EldritchUi
  class ProgressBarComponentPreview < ViewComponent::Preview
    def default
      render EldritchUi::ProgressBarComponent.new(value: 75)
    end

    def empty
      render EldritchUi::ProgressBarComponent.new(value: 0)
    end

    def full
      render EldritchUi::ProgressBarComponent.new(value: 100)
    end

    def with_different_percentages
      render template: 'components/progress_bar/previews/with_different_percentages'
    end
  end
end

