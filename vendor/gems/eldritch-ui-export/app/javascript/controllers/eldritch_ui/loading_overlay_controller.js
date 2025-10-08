import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["overlay"];
  static values = {
    visible: Boolean,
  };

  connect() {
    // Update visibility on connect
    this.updateVisibility();
  }

  visibleValueChanged() {
    this.updateVisibility();
  }

  show() {
    this.visibleValue = true;
  }

  hide() {
    this.visibleValue = false;
  }

  toggle() {
    this.visibleValue = !this.visibleValue;
  }

  // Hide overlay when clicked outside the content area
  overlayClicked(event) {
    if (event.target === this.element) {
      this.hide();
    }
  }

  // Prevent hiding when clicking inside the content
  contentClicked(event) {
    event.stopPropagation();
  }

  // Handle escape key to hide overlay
  keydown(event) {
    if (event.key === "Escape" && this.visibleValue) {
      this.hide();
      event.preventDefault();
    }
  }

  updateVisibility() {
    // Update CSS classes based on visibility state
    this.element.classList.toggle(
      "eld-loading-overlay--visible",
      this.visibleValue
    );

    // Update ARIA attributes for accessibility
    this.element.setAttribute("aria-hidden", !this.visibleValue);

    // Manage focus and scroll lock
    if (this.visibleValue) {
      this.lockScroll();
      this.trapFocus();
    } else {
      this.unlockScroll();
      this.releaseFocus();
    }

    // Dispatch custom event for external listeners
    this.dispatch(this.visibleValue ? "show" : "hide", {
      detail: { visible: this.visibleValue },
    });
  }

  lockScroll() {
    document.body.style.overflow = "hidden";
  }

  unlockScroll() {
    document.body.style.overflow = "";
  }

  trapFocus() {
    // Store the currently focused element
    this.previouslyFocusedElement = document.activeElement;
    // Focus the overlay for screen readers
    this.element.focus();
  }

  releaseFocus() {
    // Return focus to the previously focused element
    if (this.previouslyFocusedElement) {
      this.previouslyFocusedElement.focus();
      this.previouslyFocusedElement = null;
    }
  }
}
