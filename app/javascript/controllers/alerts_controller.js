import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setInterval(() => {
      this.close()
    }, 8000)
  }

  close() {
    this.element.remove()
  }
}
