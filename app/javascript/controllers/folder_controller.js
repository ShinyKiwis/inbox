import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['expander']

  connect() {
    const toggledFolders = JSON.parse(sessionStorage.getItem('toggledFolders')) || []
    toggledFolders.forEach(id => {
      const toggledNotes = $(`#${id}`)
      const expanderArrow = toggledNotes.siblings().find('.fa-angle-right');

      toggledNotes.removeClass('hide');

      expanderArrow.css('transform', 'rotate(90deg)');
      expanderArrow.css('transition', '0.3s')
    })
  }

 toggleNotes(event) {
    // event.stopPropagation() will interfere and make
    // the nested a element to be processes as HTML instead of Turbo Stream
    if (event.currentTarget !== this.element) return;

    const toggledFolders = JSON.parse(sessionStorage.getItem('toggledFolders')) || []

    const expander = $(this.expanderTarget);
    const expanderArrow = expander.find('.fa-angle-right').first();
    const nestedNotes = expander.siblings('.notes')
    const nestedNotesId = nestedNotes.attr('id');

    if(nestedNotes.hasClass('hide')) {
      if (!toggledFolders.includes(nestedNotesId)) {
        toggledFolders.push(nestedNotesId);
      }
      expanderArrow.css('transform', 'rotate(90deg)')
      expanderArrow.css('transition', '0.3s')
    } else {
      const index = toggledFolders.indexOf(nestedNotesId);
      if (index !== -1) {
        toggledFolders.splice(index, 1);
      }
      expanderArrow.css('transform', 'rotate(0deg)')
    }
    nestedNotes.toggleClass('hide');
    sessionStorage.setItem('toggledFolders', JSON.stringify(toggledFolders));
  }
}
