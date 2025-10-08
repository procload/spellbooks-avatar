import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["pill", "input"]

  connect() {
    // Initialize selected state based on input values
    this.updatePillStates()
  }

  toggle(event) {
    event.preventDefault()
    const pill = event.currentTarget
    const input = pill.querySelector('input[type="checkbox"], input[type="radio"]')

    if (!input) return

    if (input.type === "radio") {
      // For radio buttons, uncheck all others first
      this.inputTargets.forEach(i => {
        if (i.type === "radio" && i !== input) {
          i.checked = false
          this.updatePillState(i.closest('[data-pill-toggle-target="pill"]'))
        }
      })
    }

    // Toggle the clicked input
    input.checked = !input.checked
    this.updatePillState(pill)
  }

  updatePillStates() {
    this.pillTargets.forEach(pill => {
      this.updatePillState(pill)
    })
  }

  updatePillState(pill) {
    const input = pill.querySelector('input[type="checkbox"], input[type="radio"]')
    if (!input) return

    if (input.checked) {
      pill.classList.add('eld-pill--selected')
    } else {
      pill.classList.remove('eld-pill--selected')
    }
  }
}
