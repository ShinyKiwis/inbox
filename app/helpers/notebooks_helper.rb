# frozen_string_literal: true

module NotebooksHelper
  def status_icon(status_name)
    {
      'published' => 'globe',
      'private' => 'lock',
      'shared' => 'user-group',
    }[status_name]
  end
end
