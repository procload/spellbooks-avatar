import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "search",
    "list",
    "student",
    "checkbox",
    "selectAll",
    "counter",
    "clearButton",
    "submitButton",
  ];

  static values = {
    processing: Boolean,
  };

  initialize() {
    super.initialize();
    this.updateSelectedCount();
  }

  connect() {
    super.connect();
    this.updateCounter();
    this.updateRowStates();

    if (this.processingValue) {
      this.disableAllCheckboxes();
    }
  }

  processingValueChanged() {
    if (this.processingValue) {
      this.disableAllCheckboxes();
    } else {
      this.enableAllCheckboxes();
    }
  }

  disableAllCheckboxes() {
    this.checkboxTargets.forEach((checkbox) => {
      checkbox.disabled = true;
    });

    if (this.hasSelectAllTarget) {
      this.selectAllTarget.disabled = true;
    }

    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.disabled = true;
    }
  }

  enableAllCheckboxes() {
    this.checkboxTargets.forEach((checkbox) => {
      // Only enable if they weren't originally disabled
      const wasOriginallyDisabled = checkbox.hasAttribute(
        "data-originally-disabled"
      );
      if (!wasOriginallyDisabled) {
        checkbox.disabled = false;
      }
    });

    if (this.hasSelectAllTarget) {
      this.selectAllTarget.disabled = false;
    }

    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.disabled = false;
    }
  }

  updateSelectedCount() {
    const selectedCount = this.checkboxTargets.filter(
      (checkbox) => checkbox.checked
    ).length;

    // Count how many checkboxes are not disabled (can be toggled)
    const toggleableCount = this.checkboxTargets.filter(
      (checkbox) => !checkbox.disabled
    ).length;

    // Count how many toggleable checkboxes are checked
    const toggleableSelectedCount = this.checkboxTargets.filter(
      (checkbox) => !checkbox.disabled && checkbox.checked
    ).length;

    if (this.hasCounterTarget) {
      this.counterTarget.textContent = `${selectedCount} of ${this.checkboxTargets.length} selected`;
    }

    if (this.hasClearButtonTarget) {
      this.clearButtonTarget.classList.toggle(
        "hidden",
        toggleableSelectedCount === 0
      );
    }

    // Only set selectAll checked if all toggleable checkboxes are checked
    if (this.hasSelectAllTarget) {
      this.selectAllTarget.checked =
        toggleableSelectedCount === toggleableCount && toggleableCount > 0;
    }
  }

  toggleAll(event) {
    const checked = event.target.checked;
    this.checkboxTargets.forEach((checkbox) => {
      if (!checkbox.disabled) {
        checkbox.checked = checked;
      }
    });
    this.updateSelectedCount();
    this.updateRowStates();
    this.submitForm();
  }

  toggleStudent(event) {
    // Find the checkbox within the clicked row
    const checkbox = event.currentTarget.querySelector(
      'input[type="checkbox"]'
    );
    if (checkbox && !checkbox.disabled) {
      checkbox.checked = !checkbox.checked;
      this.updateSelectedCount();
      this.updateRowStates();
      this.submitForm();
    }
  }

  stopPropagation(event) {
    // Stop the click event from bubbling up to the row
    event.stopPropagation();
  }

  clearSelection() {
    this.checkboxTargets.forEach((checkbox) => {
      // Only clear checkboxes that aren't disabled
      if (!checkbox.disabled) {
        checkbox.checked = false;
      }
    });
    this.updateSelectedCount();
    this.updateRowStates();
    this.submitForm();
  }

  filter() {
    if (!this.hasSearchTarget) return;

    const query = this.searchTarget.value.toLowerCase();
    this.studentTargets.forEach((student) => {
      const nameElement = student.querySelector(
        ".eld-assign-students-form__student-name"
      );
      const emailElement = student.querySelector(
        ".eld-assign-students-form__student-email"
      );

      let shouldShow = false;

      if (nameElement) {
        const name = nameElement.textContent.toLowerCase();
        shouldShow = shouldShow || name.includes(query);
      }

      if (emailElement) {
        const email = emailElement.textContent.toLowerCase();
        shouldShow = shouldShow || email.includes(query);
      }

      student.style.display = shouldShow ? "" : "none";
    });
  }

  updateSelectAllState() {
    if (!this.hasSelectAllTarget) return;

    const totalCheckboxes = this.checkboxTargets.filter(
      (checkbox) => !checkbox.disabled
    ).length;
    const checkedCheckboxes = this.checkboxTargets.filter(
      (checkbox) => !checkbox.disabled && checkbox.checked
    ).length;

    this.selectAllTarget.checked =
      totalCheckboxes === checkedCheckboxes && totalCheckboxes > 0;
    this.selectAllTarget.indeterminate =
      checkedCheckboxes > 0 && checkedCheckboxes < totalCheckboxes;
  }

  updateCounter() {
    if (!this.hasCounterTarget) return;

    const selectedCount = this.checkboxTargets.filter(
      (checkbox) => checkbox.checked
    ).length;

    this.counterTarget.textContent = `${selectedCount} of ${this.checkboxTargets.length} selected`;

    if (this.hasClearButtonTarget) {
      const toggleableSelectedCount = this.checkboxTargets.filter(
        (checkbox) => !checkbox.disabled && checkbox.checked
      ).length;
      this.clearButtonTarget.classList.toggle(
        "hidden",
        toggleableSelectedCount === 0
      );
    }
  }

  updateRowStates() {
    this.studentTargets.forEach((row) => {
      const checkbox = row.querySelector('input[type="checkbox"]');
      if (checkbox) {
        row.classList.toggle(
          "eld-assign-students-form__student-row--selected",
          checkbox.checked
        );
      }
    });
  }

  submitForm(event) {
    // Don't submit if processing
    if (this.processingValue) return;

    // Find the closest form
    const form = this.element.closest("form");
    if (!form) return;

    // Don't submit on every change - this would be too aggressive
    // The form will be submitted when the user clicks the submit button
    // This method exists for potential future auto-save functionality
  }

  // Method to handle form submission
  handleSubmit(event) {
    if (this.processingValue) {
      event.preventDefault();
      return;
    }

    // Mark as processing to prevent double-submission
    this.processingValue = true;

    // Optionally show loading state
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.disabled = true;
      this.submitButtonTarget.textContent = "Saving...";
    }
  }

  // Method called when checkboxes change
  handleCheckboxChange(event) {
    this.updateSelectedCount();
    this.updateSelectAllState();
    this.updateRowStates();
  }
}
