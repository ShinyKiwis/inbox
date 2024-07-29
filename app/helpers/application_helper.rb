# frozen_string_literal: true

module ApplicationHelper
  def fa_icon(name)
    tag.i class: "fa-solid fa-#{name}"
  end

  def tooltip(text, &block)
    content_tag :div, class: 'tooltip' do
      concat capture(&block)
      concat content_tag :span, text, class: 'tooltip-text'
    end
  end
end
