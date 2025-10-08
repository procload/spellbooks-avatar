# frozen_string_literal: true

require "test_helper"

class EldritchUi::ProgressIndicatorComponentTest < ViewComponent::TestCase
  def test_renders_with_default_values
    render_inline(EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"]
    ))

    assert_selector(".eld-progress-indicator")
    assert_selector(".eld-progress-indicator__container")
    assert_selector(".eld-progress-indicator__bar")
    assert_selector(".eld-progress-indicator__label", count: 3)
  end

  def test_progress_percentage_at_zero
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 0
    )

    render_inline(component)
    assert_equal 0, component.send(:progress_percentage)
  end

  def test_progress_percentage_at_one_step
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 1
    )

    render_inline(component)
    # 1/3 steps completed = 33.33%
    assert_in_delta 33.33, component.send(:progress_percentage), 0.01
  end

  def test_progress_percentage_at_two_steps
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 2
    )

    render_inline(component)
    # 2/3 steps completed = 66.67%
    assert_in_delta 66.67, component.send(:progress_percentage), 0.01
  end

  def test_progress_percentage_when_completed
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 2,
      completed: true
    )

    render_inline(component)
    assert_equal 100, component.send(:progress_percentage)
  end

  def test_auto_completion_when_current_step_equals_total_steps
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 3  # Equals total steps
    )

    render_inline(component)
    assert component.send(:completed)
    assert_equal 100, component.send(:progress_percentage)
  end

  def test_auto_completion_when_current_step_exceeds_total_steps
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 5  # Exceeds total steps
    )

    render_inline(component)
    assert component.send(:completed)
    assert_equal 100, component.send(:progress_percentage)
  end

  def test_step_state_pending_when_not_started
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 0
    )

    render_inline(component)
    assert_equal "pending", component.send(:step_progress_state, 0)
    assert_equal "pending", component.send(:step_progress_state, 1)
    assert_equal "pending", component.send(:step_progress_state, 2)
  end

  def test_step_state_with_current_step
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 1
    )

    render_inline(component)
    assert_equal "completed", component.send(:step_progress_state, 0)
    assert_equal "current", component.send(:step_progress_state, 1)
    assert_equal "pending", component.send(:step_progress_state, 2)
  end

  def test_step_state_all_completed
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 3,
      completed: true
    )

    render_inline(component)
    assert_equal "completed", component.send(:step_progress_state, 0)
    assert_equal "completed", component.send(:step_progress_state, 1)
    assert_equal "completed", component.send(:step_progress_state, 2)
  end

  def test_renders_with_hash_steps
    render_inline(EldritchUi::ProgressIndicatorComponent.new(
      steps: [
        { label: "First Step" },
        { label: "Second Step" },
        { label: "Third Step" }
      ],
      current_step: 1
    ))

    assert_selector(".eld-progress-indicator__label", text: "First Step")
    assert_selector(".eld-progress-indicator__label", text: "Second Step")
    assert_selector(".eld-progress-indicator__label", text: "Third Step")
  end

  def test_renders_stimulus_data_attributes
    render_inline(EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 1
    ))

    assert_selector(
      "[data-controller='eldritch-ui--progress-indicator']"
    )
    assert_selector(
      "[data-eldritch-ui--progress-indicator-current-step-value='1']"
    )
    assert_selector(
      "[data-eldritch-ui--progress-indicator-total-steps-value='3']"
    )
    assert_selector(
      "[data-eldritch-ui--progress-indicator-completed-value='false']"
    )
  end

  def test_handles_empty_steps
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: [],
      current_step: 0
    )

    render_inline(component)
    assert_equal 0, component.send(:progress_percentage)
    refute component.send(:completed)
  end

  def test_handles_negative_current_step
    component = EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: -1
    )

    render_inline(component)
    assert_equal 0, component.send(:progress_percentage)
  end

  def test_applies_completed_css_class
    render_inline(EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      current_step: 3,
      completed: true
    ))

    assert_selector(".eld-progress-indicator--completed")
  end

  def test_accepts_custom_html_attributes
    render_inline(EldritchUi::ProgressIndicatorComponent.new(
      steps: ["Step 1", "Step 2", "Step 3"],
      id: "custom-progress",
      class: "custom-class"
    ))

    assert_selector("#custom-progress")
    assert_selector(".custom-class")
  end
end
