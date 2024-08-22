# frozen_string_literal: true

module AlertsHelper
  ALERT_MESSAGES = {
    error: 'Something went wrong!',
  }.with_indifferent_access

  ALERT_ICONS = {
    error: 'circle-exclamation',
  }.with_indifferent_access

  private_constant :ALERT_MESSAGES

  def alert(type: 'error', &block)
    content_tag(:div, class: 'alert-modal') do
      content_tag(:div, class: "alert alert-#{type}", data: { controller: :alerts }) do
        concat(content_tag(:span, '', class: 'alert-indicator'))
        concat(fa_icon(ALERT_ICONS[type]))
        concat(
          content_tag(:div, class: 'alert-body') do
            concat(content_tag(:span, ALERT_MESSAGES[type], class: 'alert-title'))
            concat(capture(&block))
          end,
        )
        concat(content_tag(:span, fa_icon('xmark'), class: 'close-icon', data: { action: 'click->alerts#close' }))
      end
    end
  end
end
