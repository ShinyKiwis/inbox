import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['title']
  static values = {
    saveUrl: String,
  }

  connect() {
    this.token = $('meta[name="csrf-token"]').attr('content');

    if($(this.titleTarget).text().length == 0) {
      $(this.titleTarget).trigger("focus");
    }
    this.debouncedSave = JSHelper.debounce(() => this.save(), 600);

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

    title.on('input', () => {
      const titleText = title.text();
      const noteItem = $(`#${title.data('titleId')}`)
      if(titleText.length === 0) {
        title.text('')
      }
      noteItem.text(JSHelper.truncate(titleText) || 'Untitled')
      this.debouncedSave();
    })
  }

  save() {
    $.ajax({
      url: this.saveUrlValue,
      type: 'PATCH',
      headers: {
        'X-CSRF-Token': this.token,
        'Accept': 'text/vnd.turbo-stream.html, text/html, application/xhtml+xml'
      },
      data: {
        note: {
          name: $(this.titleTarget).text()
        }
      },
      success: function(response) {
        Turbo.renderStreamMessage(response)
      }
    })
  }
}
