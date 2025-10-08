import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="eldritch-ui--tile"
export default class extends Controller {
  static targets = ["hiddenInput"];
  static values = {
    selectionMode: String,
    selected: Boolean,
    value: String,
    name: String,
    disabled: Boolean,
  };

  connect() {
    this.updateAriaPressed();
    this.updateHiddenInput();
  }

  // Handle click events
  click(event) {
    if (this.disabledValue) {
      event.preventDefault();
      return;
    }

    // Handle navigation
    const href = this.element.dataset.href;
    if (href && this.selectionModeValue === "none") {
      this.handleNavigation(event, href);
      return;
    }

    // Handle selection
    this.handleSelection(event);
  }

  // Handle keyboard events
  keydown(event) {
    if (this.disabledValue) return;

    // Handle Enter and Space key presses
    if (event.key === "Enter" || event.key === " ") {
      event.preventDefault();
      this.click(event);
      return;
    }

    // Handle arrow key navigation
    if (
      ["ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight"].includes(event.key)
    ) {
      event.preventDefault();
      this.handleArrowKeyNavigation(event.key);
    }
  }

  // Handle arrow key navigation between tiles
  handleArrowKeyNavigation(key) {
    const tiles = this.getTileGroup();
    const currentIndex = tiles.indexOf(this.element);

    if (currentIndex === -1) return;

    let nextIndex;
    const tilesPerRow = this.calculateTilesPerRow(tiles);

    switch (key) {
      case "ArrowLeft":
        nextIndex = currentIndex > 0 ? currentIndex - 1 : tiles.length - 1;
        break;
      case "ArrowRight":
        nextIndex = currentIndex < tiles.length - 1 ? currentIndex + 1 : 0;
        break;
      case "ArrowUp":
        nextIndex = currentIndex - tilesPerRow;
        if (nextIndex < 0) {
          // Move to last row, same column
          const remainder = tiles.length % tilesPerRow;
          const lastRowStart = tiles.length - (remainder || tilesPerRow);
          const column = currentIndex % tilesPerRow;
          nextIndex = Math.min(lastRowStart + column, tiles.length - 1);
        }
        break;
      case "ArrowDown":
        nextIndex = currentIndex + tilesPerRow;
        if (nextIndex >= tiles.length) {
          // Move to first row, same column
          nextIndex = currentIndex % tilesPerRow;
        }
        break;
    }

    if (nextIndex !== undefined && tiles[nextIndex]) {
      tiles[nextIndex].focus();
    }
  }

  // Get all tiles in the same group (same name for selection or all tiles for navigation)
  getTileGroup() {
    if (this.selectionModeValue !== "none" && this.nameValue) {
      // For selection mode, get tiles with the same name
      return Array.from(
        document.querySelectorAll(
          `[data-controller~="eldritch-ui--tile"][data-eldritch-ui--tile-name-value="${this.nameValue}"]`
        )
      ).filter((tile) => !tile.hasAttribute("aria-disabled"));
    } else {
      // For navigation mode, get all tiles in the nearest container
      const container =
        this.element.closest('[role="group"], .tiles-container, .grid') ||
        this.element.parentElement;
      return Array.from(
        container.querySelectorAll('[data-controller~="eldritch-ui--tile"]')
      ).filter((tile) => !tile.hasAttribute("aria-disabled"));
    }
  }

  // Calculate number of tiles per row based on grid layout
  calculateTilesPerRow(tiles) {
    if (tiles.length <= 1) return 1;

    const firstTile = tiles[0];
    const container =
      firstTile.closest('[role="group"], .tiles-container, .grid') ||
      firstTile.parentElement;

    // Get computed styles to detect grid or flex layout
    const containerStyles = window.getComputedStyle(container);

    // Check for CSS Grid
    if (containerStyles.display === "grid") {
      const gridTemplateColumns = containerStyles.gridTemplateColumns;
      if (gridTemplateColumns && gridTemplateColumns !== "none") {
        return gridTemplateColumns.split(" ").length;
      }
    }

    // Check for flexbox with wrapping
    if (
      containerStyles.display === "flex" &&
      containerStyles.flexWrap !== "nowrap"
    ) {
      // Calculate based on tile widths and container width
      const containerWidth = container.offsetWidth;
      const tileWidth = firstTile.offsetWidth;
      const gap = parseInt(containerStyles.gap) || 0;
      return Math.floor((containerWidth + gap) / (tileWidth + gap)) || 1;
    }

    // Fallback: check if tiles are on the same row
    const firstTileTop = firstTile.offsetTop;
    let tilesInFirstRow = 1;
    for (let i = 1; i < tiles.length; i++) {
      if (Math.abs(tiles[i].offsetTop - firstTileTop) < 5) {
        // 5px tolerance
        tilesInFirstRow++;
      } else {
        break;
      }
    }

    return tilesInFirstRow;
  }

  // Handle selection logic
  handleSelection(event) {
    if (this.selectionModeValue === "single") {
      // For single selection (radio-like), unselect others with same name
      if (this.nameValue) {
        const siblings = document.querySelectorAll(
          `[data-controller~="eldritch-ui--tile"][data-eldritch-ui--tile-name-value="${this.nameValue}"]`
        );
        siblings.forEach((sibling) => {
          if (sibling !== this.element) {
            const controller =
              this.application.getControllerForElementAndIdentifier(
                sibling,
                "eldritch-ui--tile"
              );
            if (controller) {
              controller.setSelected(false);
            }
          }
        });
      }
      this.setSelected(true);
    } else if (this.selectionModeValue === "multiple") {
      // For multiple selection (checkbox-like), toggle
      this.setSelected(!this.selectedValue);
    }

    // Emit change event
    this.dispatchChangeEvent(event);
  }

  // Handle navigation with Turbo support
  handleNavigation(event, href) {
    const turboMethod = this.element.dataset.turboMethod;
    const turboFrame = this.element.dataset.turboFrame;

    // If this has turbo attributes, handle with Turbo
    if (turboMethod) {
      event.preventDefault();

      if (window.Turbo) {
        if (turboMethod.toLowerCase() === "post") {
          // For POST requests, create a form and submit it
          this.submitTurboForm(href, turboMethod, turboFrame);
        } else {
          // For GET requests, use Turbo.visit
          const options = {
            action: turboMethod === "get" ? "advance" : "replace",
          };
          if (turboFrame) {
            options.frame = turboFrame;
          }
          window.Turbo.visit(href, options);
        }
      } else {
        // Fallback if Turbo is not available
        window.location.href = href;
      }
    } else {
      // Normal navigation - let the browser handle it
      window.location.href = href;
    }
  }

  // Create and submit a form for Turbo POST requests
  submitTurboForm(href, method, frame) {
    const form = document.createElement("form");
    form.method = "POST";
    form.action = href;

    // Add CSRF token
    const csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      ?.getAttribute("content");
    if (csrfToken) {
      const csrfInput = document.createElement("input");
      csrfInput.type = "hidden";
      csrfInput.name = "authenticity_token";
      csrfInput.value = csrfToken;
      form.appendChild(csrfInput);
    }

    // Add method override if needed
    if (method.toLowerCase() !== "post") {
      const methodInput = document.createElement("input");
      methodInput.type = "hidden";
      methodInput.name = "_method";
      methodInput.value = method.toLowerCase();
      form.appendChild(methodInput);
    }

    // Set turbo frame if specified
    if (frame) {
      form.setAttribute("data-turbo-frame", frame);
    }

    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);
  }

  // Set selected state
  setSelected(selected) {
    this.selectedValue = selected;
    this.updateAriaPressed();
    this.updateHiddenInput();
    this.updateClasses();
  }

  // Update aria-pressed attribute
  updateAriaPressed() {
    if (this.selectionModeValue === "none") {
      this.element.removeAttribute("aria-pressed");
    } else {
      this.element.setAttribute("aria-pressed", this.selectedValue.toString());
    }
  }

  // Update hidden input for Rails form compatibility
  updateHiddenInput() {
    if (
      this.hasHiddenInputTarget &&
      this.nameValue &&
      this.selectionModeValue !== "none"
    ) {
      this.hiddenInputTarget.value = this.selectedValue ? this.valueValue : "";
    }
  }

  // Update CSS classes
  updateClasses() {
    if (this.selectedValue) {
      this.element.classList.add("eld-tile--selected");
    } else {
      this.element.classList.remove("eld-tile--selected");
    }
  }

  // Dispatch change event
  dispatchChangeEvent(originalEvent) {
    const changeEvent = new CustomEvent("eldritch-ui:tile:change", {
      detail: {
        selected: this.selectedValue,
        value: this.valueValue,
        selectionMode: this.selectionModeValue,
        name: this.nameValue,
        originalEvent,
      },
      bubbles: true,
      composed: true,
      cancelable: true,
    });

    this.element.dispatchEvent(changeEvent);
  }

  // Value change callbacks
  selectedValueChanged() {
    this.updateAriaPressed();
    this.updateHiddenInput();
    this.updateClasses();
  }

  disabledValueChanged() {
    this.element.setAttribute("tabindex", this.disabledValue ? "-1" : "0");
    if (this.disabledValue) {
      this.element.setAttribute("aria-disabled", "true");
    } else {
      this.element.removeAttribute("aria-disabled");
    }
  }
}
