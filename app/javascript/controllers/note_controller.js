import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['title']
  connect() {
    if($(this.titleTarget).text().length == 0) {
      $(this.titleTarget).trigger("focus");
    }

    this.checkNoteItemLoaded = this.checkNoteItemLoaded.bind(this)
    this.intervalId = setInterval(this.checkNoteItemLoaded, 100)
  }

  checkNoteItemLoaded() {
    const noteItem = $(`#${$(this.titleTarget).data('titleId')}`)
    if(noteItem.length !== 0) {
      clearInterval(this.intervalId)
      this.handleEditNoteTitle();
    }
  }

  handleEditNoteTitle() {
    const title = $(this.titleTarget)
    const noteItem = $(`#${title.data('titleId')}`)

    title.on('input', function() {
      const titleText = title.text();
      if(titleText.length === 0) {
        title.text('')
      }
      noteItem.text(JSHelper.truncate(titleText) || 'Untitled')
    })
  }
}
