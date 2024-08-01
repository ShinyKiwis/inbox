# frozen_string_literal: true

module NotesHelper
  def note_item(item)
    item_klass = item.is_a?(Note) ? Note : Notebook
  end

  private

  def note(note)
  end

  def folder(folder)
  end
end
