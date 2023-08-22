import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-button"
export default class extends Controller {
  click(e) {
    const btn = e.currentTarget
    if (btn.classList.contains("bg-blue-300")) {
      btn.classList.remove("bg-blue-300")
    } else {
      btn.classList.add("bg-blue-300")
    }
  }

}
