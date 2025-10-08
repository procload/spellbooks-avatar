import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "letter"];
  static values = {
    selected: Boolean,
    disabled: Boolean,
  };

  connect() {
    console.log("AnswerChoice controller connected!");
    console.log("Initial state:", {
      selectedValue: this.selectedValue,
      inputChecked: this.inputTarget.checked,
      name: this.inputTarget.name,
      value: this.inputTarget.value,
      element: this.element,
    });

    // Store reference to this controller on the element for radio group updates
    this.element.answerChoiceController = this;

    // Force sync with actual radio button state, ignore the data attribute
    this.selectedValue = this.inputTarget.checked;

    // Listen for changes to this radio button
    this.inputTarget.addEventListener(
      "change",
      this.handleRadioChange.bind(this)
    );

    // Update visual state on connect
    this.updateSelectedState();
  }

  select(event) {
    // Prevent selection if disabled
    if (this.disabledValue) {
      event.preventDefault();
      event.stopPropagation();
      return;
    }

    // If clicked on the container but not the radio input itself,
    // programmatically click the radio input
    if (event.target !== this.inputTarget) {
      // Don't allow "unselecting" if already selected - this is a radio button!
      if (!this.inputTarget.checked) {
        this.inputTarget.click();
        this.inputTarget.focus();
      }
    }
  }

  handleRadioChange() {
    console.log("Radio changed:", {
      name: this.inputTarget.name,
      value: this.inputTarget.value,
      checked: this.inputTarget.checked,
    });

    // Update all radio buttons in the same group
    this.updateRadioGroup();
  }

  updateRadioGroup() {
    // Find all radio buttons with the same name
    const allRadios = document.querySelectorAll(
      `input[name="${this.inputTarget.name}"]`
    );

    allRadios.forEach((radio) => {
      // Find the corresponding Stimulus controller
      const answerChoiceElement = radio.closest(
        '[data-controller*="eldritch-ui--answer-choice"]'
      );
      if (answerChoiceElement && answerChoiceElement.answerChoiceController) {
        // Update the visual state for each answer choice
        answerChoiceElement.answerChoiceController.updateSelectedState();
      }
    });
  }

  updateSelectedState() {
    // Use the actual radio button's checked state, not the data attribute
    const isSelected = this.inputTarget.checked;

    console.log("Updating selected state:", {
      name: this.inputTarget.name,
      value: this.inputTarget.value,
      isSelected: isSelected,
      hasSelectedClass: this.element.classList.contains(
        "eld-answer-choice--selected"
      ),
    });

    // Update CSS classes based on actual selection state
    this.element.classList.toggle("eld-answer-choice--selected", isSelected);

    // Also update the letter badge styling
    if (this.hasLetterTarget) {
      this.letterTarget.classList.toggle(
        "eld-answer-choice__letter--selected",
        isSelected
      );
    }

    // Update ARIA attributes for accessibility
    this.element.setAttribute("aria-selected", isSelected);

    // Update the Stimulus value to match the actual state
    this.selectedValue = isSelected;

    // Dispatch custom event for external listeners
    this.dispatch("change", {
      detail: {
        selected: isSelected,
        value: this.inputTarget.value,
        name: this.inputTarget.name,
      },
    });
  }

  // Handle keyboard navigation
  keydown(event) {
    if (this.disabledValue) return;

    // Space or Enter key selects the answer
    if (event.key === " " || event.key === "Enter") {
      event.preventDefault();
      this.inputTarget.click();
    }
  }
}
