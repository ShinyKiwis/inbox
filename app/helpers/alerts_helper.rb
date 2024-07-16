# frozen_string_literal: true

module AlertsHelper
  def alert(type: 'error', &block)
    stimulus_controller = :alerts
    content_tag(:div, class: "alert alert-#{type}", data: { controller: stimulus_controller }) do
      concat(capture(&block))
      concat(content_tag(:span, fa_icon(:xmark), class: 'close-icon', data: { action: "click->#{stimulus_controller}#close" }))
    end
  end
end
