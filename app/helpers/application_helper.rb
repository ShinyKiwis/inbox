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
end
