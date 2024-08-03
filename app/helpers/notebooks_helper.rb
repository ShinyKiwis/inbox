# frozen_string_literal: true

module NotebooksHelper
  def status_icon(status_name)
    {
      'published' => 'globe',
      'private' => 'lock',
      'shared' => 'user-group',
    }[status_name]
  end

  def notebook_item(notebook)
    active_class = active_class(notebook_path(notebook))
    link_to notebook_path(notebook), class: "notebook #{active_class}" do
      concat content_tag(:span, '', class: 'active-indicator') if active_class
      concat fa_icon 'book'
      concat content_tag(:span, notebook.name)
    end
  end
end
