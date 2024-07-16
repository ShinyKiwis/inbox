# frozen_string_literal: true

module ApplicationHelper
  def fa_icon(name)
    parsed_name = name.to_s.tr('_', '-')
    tag.i(class: "fa-solid fa-#{parsed_name}")
  end
end
