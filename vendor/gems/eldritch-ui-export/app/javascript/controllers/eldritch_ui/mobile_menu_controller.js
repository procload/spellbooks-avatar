import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["overlay", "menu"];

  connect() {
    // Bind escape key to close menu
    this.boundCloseOnEscape = this.closeOnEscape.bind(this);
  }

  disconnect() {
    document.removeEventListener("keydown", this.boundCloseOnEscape);
  }

  toggle(event) {
    event.preventDefault();
    event.stopPropagation();

    const overlay = this.overlayTarget;
    const menu = this.menuTarget;
    const isHidden = overlay.classList.contains(
      "eld-sidebar__mobile-overlay--hidden"
    );

    if (isHidden) {
      this.open();
    } else {
      this.close();
    }
  }

  open() {
    this.overlayTarget.classList.remove("eld-sidebar__mobile-overlay--hidden");
    this.menuTarget.classList.remove("eld-sidebar__mobile-menu--hidden");

    // Add escape key listener
    document.addEventListener("keydown", this.boundCloseOnEscape);

    // Prevent body scroll
    document.body.style.overflow = "hidden";
  }

  close() {
    this.overlayTarget.classList.add("eld-sidebar__mobile-overlay--hidden");
    this.menuTarget.classList.add("eld-sidebar__mobile-menu--hidden");

    // Remove escape key listener
    document.removeEventListener("keydown", this.boundCloseOnEscape);

    // Restore body scroll
    document.body.style.overflow = "";
  }

  closeOnEscape(event) {
    if (event.key === "Escape") {
      this.close();
    }
  }
}
