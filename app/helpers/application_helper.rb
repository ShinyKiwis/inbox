# frozen_string_literal: true

module ApplicationHelper
  def fa_icon(name)
    parsed_name = name.to_s.tr('_', '-')
    tag.i(class: "fa-solid fa-#{parsed_name}")
  end

  def avatar(user_id = nil)
    user = user_id ? User.find(user_id) : current_user
    content_tag :span, class: 'avatar' do
      concat user.default_avatar_image.html_safe
      concat(content_tag(:span, fa_icon(:angle_down), class: 'avatar-expander'))
    end
  end
end
