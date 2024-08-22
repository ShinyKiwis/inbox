# frozen_string_literal: true

module NotesHelper
  def note_item(notebook, item)
    if item.is_a?(Note)
      render_note notebook, item
    elsif item.is_a?(Notebook)
      render_folder item
    end
  end

  def render_note(notebook, note)
    note_path = if notebook.parent.present?
                  notebook_note_path(notebook.outermost_parent, note)
                else
                  notebook_note_path(notebook, note)
                end

    content_tag :div, class: "note #{active_class(note_path)}", data: { controller: 'context-menu' } do
      concat link_to note.name&.truncate(25) || 'Untitled', note_path, id: note.hashed_param, data: { turbo_stream: true, turbo_action: :replace }
      concat tooltip_wrapper('Rename, remove, ...', allow_actions: ['delete_note'])
      concat render partial: 'notebooks/content_menu', locals: { notebook: notebook, note: note }
    end
  end

  def render_folder(folder)
    folder_content = content_tag :div, class: 'note' do
      concat fa_icon 'angle-right'
      concat content_tag :span, folder.name
      concat tooltip_wrapper('Add, remove, ...', allow_actions: ['new_note', 'new_folder', 'delete_folder'])
    end

    content_tag :div, class: 'folder', data: { controller: 'context-menu' } do
      concat render partial: 'notebooks/content_menu', locals: { notebook: folder, note: nil }
      concat(
        content_tag(:div, class: 'folder-expander', data: { controller: 'folder', folder_target: 'expander', action: 'click->folder#toggleNotes' }) do
          concat folder_content
        end,
      )
      concat(
        content_tag(:div, class: 'notes hide', id: "notes-#{folder.hashed_param}") do
          folder.items.each do |note|
            concat note_item folder, note
          end
        end,
      )
    end
  end
end
