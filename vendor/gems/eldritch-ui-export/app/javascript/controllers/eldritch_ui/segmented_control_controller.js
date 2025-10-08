import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="eldritch-ui--segmented-control"
export default class extends Controller {
  static targets = ["hiddenInput"];
  static values = {
    value: String,
    name: String,
    disabled: Boolean,
  };

  connect() {
    this.updateAriaStates();
    this.updateHiddenInput();
  }

  // Handle segment selection (used by template)
  select(event) {
    this.click(event);
  }

  // Handle click events on segments
  click(event) {
    if (this.disabledValue) {
      event.preventDefault();
      return;
    }

    // Find the clicked segment
    const segment = event.target.closest('[role="radio"]');
    if (!segment) return;

    // Check if the segment is disabled
    if (segment.getAttribute("aria-disabled") === "true") {
      event.preventDefault();
      return;
    }

    const newValue = segment.dataset.value;
    this.selectValue(newValue, event);
  }

  // Handle keyboard navigation
  keydown(event) {
    if (this.disabledValue) return;

    const segments = this.getAllSegments();
    const currentIndex = this.getCurrentSegmentIndex(segments);
    let newIndex = currentIndex;

    switch (event.key) {
      case "ArrowLeft":
      case "ArrowUp":
        event.preventDefault();
        newIndex = this.getPreviousEnabledIndex(segments, currentIndex);
        break;
      case "ArrowRight":
      case "ArrowDown":
        event.preventDefault();
        newIndex = this.getNextEnabledIndex(segments, currentIndex);
        break;
      case "Home":
        event.preventDefault();
        newIndex = this.getFirstEnabledIndex(segments);
        break;
      case "End":
        event.preventDefault();
        newIndex = this.getLastEnabledIndex(segments);
        break;
      case " ":
      case "Enter":
        event.preventDefault();
        // Space and Enter select the currently focused segment
        const focusedSegment = segments[currentIndex];
        if (
          focusedSegment &&
          focusedSegment.getAttribute("aria-disabled") !== "true"
        ) {
          this.selectValue(focusedSegment.dataset.value, event);
        }
        return;
      default:
        return;
    }

    // Focus and select the new segment
    if (newIndex !== -1 && newIndex !== currentIndex) {
      const newSegment = segments[newIndex];
      if (newSegment) {
        newSegment.focus();
        this.selectValue(newSegment.dataset.value, event);
      }
    }
  }

  // Select a value and update the component state
  selectValue(newValue, originalEvent = null) {
    if (this.valueValue !== newValue) {
      const oldValue = this.valueValue;
      this.valueValue = newValue;
      this.updateAriaStates();
      this.updateHiddenInput();
      this.dispatchChangeEvent(oldValue, newValue, originalEvent);
    }
  }

  // Update ARIA states and visual classes for all segments
  updateAriaStates() {
    const segments = this.getAllSegments();
    segments.forEach((segment) => {
      const segmentValue = segment.dataset.value;
      const isSelected = segmentValue === this.valueValue;
      const isDisabled =
        segment.getAttribute("aria-disabled") === "true" || this.disabledValue;

      segment.setAttribute("aria-checked", isSelected.toString());
      segment.setAttribute("tabindex", isSelected && !isDisabled ? "0" : "-1");

      // Update visual classes
      if (isSelected) {
        segment.classList.add("eld-segmented-control__segment--selected");
      } else {
        segment.classList.remove("eld-segmented-control__segment--selected");
      }
    });
  }

  // Update hidden input for Rails form compatibility
  updateHiddenInput() {
    if (this.hasHiddenInputTarget && this.nameValue) {
      this.hiddenInputTarget.value = this.valueValue;
    }
  }

  // Get all segment elements
  getAllSegments() {
    return Array.from(this.element.querySelectorAll('[role="radio"]'));
  }

  // Get the index of the currently selected/focused segment
  getCurrentSegmentIndex(segments) {
    return segments.findIndex(
      (segment) => segment.dataset.value === this.valueValue
    );
  }

  // Get the previous enabled segment index
  getPreviousEnabledIndex(segments, currentIndex) {
    let index = currentIndex - 1;
    while (index >= 0) {
      if (segments[index].getAttribute("aria-disabled") !== "true") {
        return index;
      }
      index--;
    }
    // Wrap to the end
    index = segments.length - 1;
    while (index > currentIndex) {
      if (segments[index].getAttribute("aria-disabled") !== "true") {
        return index;
      }
      index--;
    }
    return currentIndex; // No enabled segments found
  }

  // Get the next enabled segment index
  getNextEnabledIndex(segments, currentIndex) {
    let index = currentIndex + 1;
    while (index < segments.length) {
      if (segments[index].getAttribute("aria-disabled") !== "true") {
        return index;
      }
      index++;
    }
    // Wrap to the beginning
    index = 0;
    while (index < currentIndex) {
      if (segments[index].getAttribute("aria-disabled") !== "true") {
        return index;
      }
      index++;
    }
    return currentIndex; // No enabled segments found
  }

  // Get the first enabled segment index
  getFirstEnabledIndex(segments) {
    for (let i = 0; i < segments.length; i++) {
      if (segments[i].getAttribute("aria-disabled") !== "true") {
        return i;
      }
    }
    return -1;
  }

  // Get the last enabled segment index
  getLastEnabledIndex(segments) {
    for (let i = segments.length - 1; i >= 0; i--) {
      if (segments[i].getAttribute("aria-disabled") !== "true") {
        return i;
      }
    }
    return -1;
  }

  // Dispatch change event
  dispatchChangeEvent(oldValue, newValue, originalEvent) {
    const changeEvent = new CustomEvent(
      "eldritch-ui:segmented-control:change",
      {
        detail: {
          value: newValue,
          oldValue: oldValue,
          name: this.nameValue,
          originalEvent,
        },
        bubbles: true,
        composed: true,
        cancelable: true,
      }
    );

    this.element.dispatchEvent(changeEvent);
  }

  // Value changed callback
  valueValueChanged() {
    this.updateAriaStates();
    this.updateHiddenInput();
  }

  // Disabled state changed callback
  disabledValueChanged() {
    this.updateAriaStates();
  }
}
