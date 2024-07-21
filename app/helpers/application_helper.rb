# frozen_string_literal: true

module ApplicationHelper
  def active_sidebar_item?(current_path)
    request.path == current_path || request.path.include?(current_path)
  end

  def fa_icon(name)
    tag.i(class: "fa-solid fa-#{name}")
  end
end
