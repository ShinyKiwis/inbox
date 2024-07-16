import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setInterval(() => {
      this.close()
    }, 10000)
  }

  close() {
    this.element.remove()
  }
}
