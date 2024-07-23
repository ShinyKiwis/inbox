# frozen_string_literal: true

module ApplicationHelper
  def fa_icon(name)
    tag.i(class: "fa-solid fa-#{name}")
  end
end
