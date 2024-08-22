# frozen_string_literal: true

module ApplicationHelper
  def fa_icon(name)
    tag.i class: "fa-solid fa-#{name}"
  end

  def tooltip(options, &block)
    content_tag :div, class: 'tooltip', data: options[:data] do
      concat capture(&block)
      concat content_tag :span, options[:text], class: 'tooltip-text'
    end
  end

  def tooltip_wrapper(tooltip_text, allow_actions: [])
    tooltip text: tooltip_text, data: { action: 'click->context-menu#toggle', allow_items: allow_actions.to_json } do
      fa_icon 'ellipsis'
    end
  end

  def active_class(current_path)
    request.path.include?(current_path) ? 'active' : nil
  end
end
