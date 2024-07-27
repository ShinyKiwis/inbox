import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['modal']

  toggle(event) {
    event.preventDefault();
    if(this.modalTarget.classList.contains("hide")) {
      this.modalTarget.classList.remove("hide")
    }else {
      this.modalTarget.classList.add("hide")
    }
  }
}
