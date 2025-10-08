import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static identifier = "eldritch-ui--button";

  toggle(event) {
    // Get current aria-pressed state
    const currentPressed = this.element.getAttribute("aria-pressed");

    // Toggle the state
    const newPressed = currentPressed === "true" ? "false" : "true";

    // Update aria-pressed attribute
    this.element.setAttribute("aria-pressed", newPressed);

    // Toggle the pressed CSS class
    this.element.classList.toggle("eld-btn--pressed", newPressed === "true");

    // Dispatch custom event with the new state
    this.dispatch("toggled", {
      detail: {
        pressed: newPressed === "true",
        element: this.element,
      },
      bubbles: true,
    });
  }
}
