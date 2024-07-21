# frozen_string_literal: true

module AlertsHelper
  def alert(type: 'error', &block)
    content_tag(:div, class: "alert alert-#{type}", data: { controller: :alerts }) do
      concat(capture(&block))
      concat(content_tag(:span, fa_icon(:xmark), class: 'close-icon', data: { action: 'click->alerts#close' }))
    end
  end
end
