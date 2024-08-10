import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['title']
  static values = {
    saveUrl: String,
    csrfToken: String
  }

  connect() {
    if($(this.titleTarget).text().length == 0) {
      $(this.titleTarget).trigger("focus");
    }

    // Waiting for all turbo frames are loaded with turbo-stream then clear
    // the interval when get the targeted element
    // TODO: Update this logic when turbo has update for this
    // Feel free to make a PR if you find out a better solution for this
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

    title.on('input', () => {
      const titleText = title.text();
      if(titleText.length === 0) {
        title.text('')
      }
      noteItem.text(JSHelper.truncate(titleText) || 'Untitled')
      this.save();
    })
  }

  save() {
    clearTimeout(this.saveTimeoutId);
    this.saveTimeoutId = setTimeout(() => {
      console.log('saved')
      $.ajax({
        url: this.saveUrlValue,
        type: 'PATCH',
        headers: {
          'X-CSRF-Token': this.csrfTokenValue
        },
        data: {
          note: {
            name: $(this.titleTarget).text()
          }
        },
        dataType: 'json'
      })
    }, 800);
  }
}
