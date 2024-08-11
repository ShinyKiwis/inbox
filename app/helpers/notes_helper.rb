# frozen_string_literal: true

module NotesHelper
  def note_item(notebook, item)
    if item.is_a?(Note)
      note notebook, item
    else
      folder item
    end
  end

  private

  def note(notebook, note)
    note_path = notebook_note_path(notebook, note)
    content_tag :div, class: "note #{active_class(note_path)}" do
      link_to note_path, id: note.hashed_param, data: { turbo_frame: '_top' } do
        note.name&.truncate(25) || 'Untitled'
      end
    end
  end

  def folder(folder)
  end
end
