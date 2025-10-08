import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="eldritch-ui--tag"
export default class extends Controller {
  dismiss(event) {
    event.stopPropagation()
    
    // Get the tag value if it exists
    const value = this.element.dataset.value
    
    // Create a custom event that can be cancelled
    const dismissEvent = new CustomEvent("eldritch-ui:tag:dismiss", {
      detail: { event, value },
      bubbles: true,
      composed: true,
      cancelable: true
    })
    
    // Emit the event and check if it was cancelled
    const wasHandled = !this.element.dispatchEvent(dismissEvent)
    
    // Only auto-remove from DOM if the event wasn't cancelled
    if (!wasHandled) {
      // Add a fade-out animation if you want
      this.element.style.opacity = "0"
      this.element.style.transform = "scale(0.8)"
      
      setTimeout(() => {
        if (this.element.parentNode) {
          this.element.parentNode.removeChild(this.element)
        }
      }, 150) // Match the transition duration
    }
  }
}