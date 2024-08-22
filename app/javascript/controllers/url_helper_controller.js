import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.token = $('meta[name="csrf-token"]').attr('content');
  }

  addCurrentUrl(event) {
    event.preventDefault();

    const url = new URL(event.currentTarget.href);
    const currentPath = window.location.pathname;

    $.ajax({
      url: url,
      type: 'PATCH',
      headers: {
        'X-CSRF-Token': this.token,
        'Accept': 'text/vnd.turbo-stream.html, text/html, application/xhtml+xml'
      },
      data: {
        current_path: currentPath
      },
      success: function(response) {
        Turbo.renderStreamMessage(response)
      }
    })
  }
}
