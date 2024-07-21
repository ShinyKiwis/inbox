import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['dropdown']

  connect() {
    this.dropdownTarget.addEventListener('click', function(event) {
      event.stopPropagation();
    })
  }

  toggle() {
    if(this.dropdownTarget.classList.contains("hide")) {
      this.dropdownTarget.classList.remove("hide")
    }else {
      this.dropdownTarget.classList.add("hide")
    }
  }
}
