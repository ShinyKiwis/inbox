# frozen_string_literal: true

module ComponentsHelper
  def main_sidebar_item(path, action, icon)
    active_class = active_sidebar_item?(path) ? 'active' : ''
    link_to(path, class: "item #{active_class}") do
      concat(content_tag(:div, class: 'icon') do
        fa_icon(icon)
      end)
      concat(content_tag(:span, action))
    end
  end
end
