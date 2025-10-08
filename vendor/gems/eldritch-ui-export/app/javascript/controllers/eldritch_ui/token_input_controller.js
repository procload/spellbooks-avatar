import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="eldritch-ui--token-input" (simplified - no suggestions)
export default class extends Controller {
  static targets = ["input", "hiddenInput", "tokensContainer", "token"];

  static values = {
    separator: { type: String, default: "," },
    allowDuplicates: { type: Boolean, default: false },
    caseSensitive: { type: Boolean, default: false },
  };

  connect() {
    this.tokens = this.parseTokensFromHiddenInput();

    // Bind event listener for popular tag selections
    this.boundHandlePopularTag = this.handlePopularTag.bind(this);
    this.element.addEventListener('popular-tag:add', this.boundHandlePopularTag);

    console.log("Token input controller connected", {
      tokens: this.tokens,
      separator: this.separatorValue,
      allowDuplicates: this.allowDuplicatesValue,
    });
  }

  disconnect() {
    // Remove event listener
    if (this.boundHandlePopularTag) {
      this.element.removeEventListener('popular-tag:add', this.boundHandlePopularTag);
    }
  }

  // Handle popular tag addition
  handlePopularTag(event) {
    const tag = event.detail?.value;
    if (tag) {
      const success = this.addToken(tag);
      if (success) {
        this.renderTokens();
        this.updateHiddenInput();

        // Clear the input field
        this.inputTarget.value = '';
      }

      event.preventDefault();
      event.stopPropagation();
    }
  }

  // Parse tokens from the hidden input value
  parseTokensFromHiddenInput() {
    const value = this.hiddenInputTarget.value;
    if (!value) return [];

    return value
      .split(this.separatorValue)
      .map((token) => token.trim())
      .filter((token) => token.length > 0);
  }

  // Update the hidden input and emit change event
  updateHiddenInput() {
    const value = this.tokens.join(this.separatorValue);
    this.hiddenInputTarget.value = value;

    // Emit a change event for form handling
    this.hiddenInputTarget.dispatchEvent(
      new Event("change", { bubbles: true })
    );

    // Emit custom event for external listeners
    this.element.dispatchEvent(
      new CustomEvent("eldritch-ui:token-input:change", {
        detail: { tokens: this.tokens, value },
        bubbles: true,
      })
    );
  }

  // Add a new token
  addToken(tokenText) {
    const trimmed = tokenText.trim();
    if (!trimmed) return false;

    // Check for duplicates if not allowed
    if (!this.allowDuplicatesValue) {
      const exists = this.caseSensitiveValue
        ? this.tokens.includes(trimmed)
        : this.tokens.some(
            (token) => token.toLowerCase() === trimmed.toLowerCase()
          );

      if (exists) return false;
    }

    this.tokens.push(trimmed);
    this.renderTokens();
    this.updateHiddenInput();
    this.clearInput();

    console.log("Token added:", trimmed);
    return true;
  }

  // Remove a token
  removeToken(event) {
    const tokenValue = event.detail.value;
    const index = this.tokens.indexOf(tokenValue);

    if (index > -1) {
      this.tokens.splice(index, 1);
      this.renderTokens();
      this.updateHiddenInput();

      console.log("Token removed:", tokenValue);
    }

    // Prevent the tag from auto-removing itself
    event.preventDefault();
  }

  // Render tokens in the DOM
  renderTokens() {
    // Clear existing tokens
    this.tokensContainerTarget.innerHTML = "";

    // Add each token as a tag component
    this.tokens.forEach((token) => {
      const tagElement = this.createTagElement(token);
      this.tokensContainerTarget.appendChild(tagElement);
    });
  }

  // Create a tag element for a token
  createTagElement(token) {
    const tagElement = document.createElement("span");
    tagElement.className = "eld-tag eld-tag--dismissible";
    tagElement.dataset.eldritchUiTokenInputTarget = "token";
    tagElement.dataset.value = token;
    tagElement.dataset.controller = "eldritch-ui--tag";
    tagElement.dataset.action =
      "eldritch-ui:tag:dismiss->eldritch-ui--token-input#removeToken";

    tagElement.innerHTML = `
      <span class="eld-tag__content">${this.escapeHtml(token)}</span>
      <button
        type="button"
        class="eld-tag__dismiss"
        aria-label="Remove tag"
        data-action="click->eldritch-ui--tag#dismiss"
      >×</button>
    `;

    return tagElement;
  }

  // Escape HTML to prevent XSS
  escapeHtml(text) {
    const div = document.createElement("div");
    div.textContent = text;
    return div.innerHTML;
  }

  // Clear the input field
  clearInput() {
    this.inputTarget.value = "";
  }

  // Handle keydown events (simplified - only Enter key)
  handleKeydown(event) {
    switch (event.key) {
      case "Enter":
        event.preventDefault();
        const value = this.inputTarget.value.trim();
        if (value) {
          this.addToken(value);
        }
        break;
    }
  }

  // Handle focus events
  handleFocus(event) {
    console.log("Input focused");
  }

  // Handle blur events
  handleBlur(event) {
    console.log("Input blurred");
  }

  // Focus the input field
  focus() {
    this.inputTarget.focus();
  }

  // Programmatically replace tokens with provided list
  setTokens(tokens) {
    const values = Array.isArray(tokens) ? tokens.map(token => token?.toString().trim()).filter(Boolean) : []

    this.tokens = []

    values.forEach(token => {
      if (!this.allowDuplicatesValue) {
        const exists = this.caseSensitiveValue
          ? this.tokens.includes(token)
          : this.tokens.some(existing => existing.toLowerCase() === token.toLowerCase())

        if (exists) return
      }

      this.tokens.push(token)
    })

    this.renderTokens()
    this.updateHiddenInput()
    this.clearInput()
  }
}
