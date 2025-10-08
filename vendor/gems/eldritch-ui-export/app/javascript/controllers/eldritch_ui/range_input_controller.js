import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="eldritch-ui--range-input"
export default class extends Controller {
  static targets = ["input", "valueDisplay"]
  static values = { showValue: Boolean }

  connect() {
    if (this.showValueValue && this.hasValueDisplayTarget) {
      this.updateValue()
    }
  }

  updateValue() {
    if (this.showValueValue && this.hasValueDisplayTarget) {
      this.valueDisplayTarget.textContent = this.inputTarget.value
    }
  }
}