import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['title']
  connect() {
    $(this.titleTarget).on('click', () => {
      this.handleEditNoteTitle();
    })
  }

  handleEditNoteTitle() {
    const title = $(this.titleTarget)
    const noteItem = $(`#${title.data('titleId')}`)

    title.on('input', function() {
      const titleText = title.text();
      if(titleText.length === 0) {
        title.text('')
      }
      noteItem.text(titleText || 'Untitled')
    })
  }
}
