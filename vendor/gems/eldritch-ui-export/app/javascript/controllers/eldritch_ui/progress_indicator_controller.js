import { Controller } from "@hotwired/stimulus";

// Eldritch UI Progress Indicator Controller
// Handles dynamic progress updates via Stimulus values
export default class extends Controller {
  static targets = ["progressBar"];
  static values = {
    currentStep: { type: Number, default: 0 },
    totalSteps: { type: Number, default: 3 },
    completed: { type: Boolean, default: false },
  };

  connect() {
    this.updateProgress();
  }

  // Automatically update progress when currentStep changes
  currentStepValueChanged() {
    // Auto-complete when current_step reaches or exceeds total steps
    if (this.currentStepValue >= this.totalStepsValue && this.totalStepsValue > 0) {
      this.completedValue = true;
    }
    this.updateProgress();
  }

  // Automatically update progress when completed changes
  completedValueChanged() {
    this.updateProgress();
  }

  // Calculate and update the progress bar width
  updateProgress() {
    if (!this.hasProgressBarTarget) return;

    const percentage = this.calculatePercentage();
    this.progressBarTarget.style.width = `${percentage}%`;

    // Update ARIA attributes
    this.element.setAttribute("aria-valuenow", Math.round(percentage));

    // Dispatch custom event for external listeners
    const progressEvent = new CustomEvent("progress-indicator:updated", {
      detail: {
        currentStep: this.currentStepValue,
        totalSteps: this.totalStepsValue,
        percentage: percentage,
        completed: this.completedValue,
      },
      bubbles: true,
    });

    this.element.dispatchEvent(progressEvent);
  }

  // Calculate progress percentage based on current step
  calculatePercentage() {
    if (this.completedValue) return 100;
    if (this.totalStepsValue === 0) return 0;
    if (this.currentStepValue <= 0) return 0;

    // currentStep represents the step INDEX currently being worked on (0-based)
    // Progress fills based on steps BEFORE the current step
    // If currentStep is 0, 0% (nothing done yet)
    // If currentStep is 1, 33% (step 0 done, working on step 1)
    // If currentStep is 2, 66% (steps 0-1 done, working on step 2)
    const stepSize = 100.0 / this.totalStepsValue;
    const percentage = this.currentStepValue * stepSize;

    return Math.min(percentage, 100);
  }

  // Public API: Set current step programmatically
  setCurrentStep(stepIndex) {
    this.currentStepValue = stepIndex;
  }

  // Public API: Mark as completed
  markCompleted() {
    this.completedValue = true;
  }

  // Public API: Reset to beginning
  reset() {
    this.currentStepValue = 0;
    this.completedValue = false;
  }

  // Public API: Advance to next step
  nextStep() {
    if (this.currentStepValue < this.totalStepsValue - 1) {
      this.currentStepValue++;
    } else {
      this.markCompleted();
    }
  }

  // Public API: Go back to previous step
  previousStep() {
    if (this.currentStepValue > 0) {
      this.currentStepValue--;
      this.completedValue = false;
    }
  }
}
