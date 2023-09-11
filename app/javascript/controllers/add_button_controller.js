import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  click(e) {
    const btn = e.currentTarget
    const groupIcons = btn.closest('.select-icon')
    const icons = groupIcons.querySelectorAll('.icon')
    
    icons.forEach((icon) => {
      if (icon == btn) {
        icon.classList.add("bg-blue-300","border-blue-300")
        icon.classList.remove("border-gray-300")
      } else {
        icon.classList.remove("bg-blue-300","border-blue-300")
        icon.classList.add("border-gray-300")
      }
    })
  }

}
  