# frozen_string_literal: true

module AvatarHelper
  def avatar(options = {})
    self.user = options[:user] || current_user
    content_tag(:span, class: 'avatar', data: { controller: :avatar, action: 'click->avatar#toggle' }) do
      concat(avatar_image)
      if options[:with_expander]
        concat(content_tag(:span, fa_icon(:angle_down), class: 'avatar-expander'))
        concat(avatar_dropdown)
      end
    end
  end

  private

  attr_accessor :user

  def avatar_dropdown
    content_tag(:div, class: 'avatar-dropdown hide togglable', data: { avatar_target: 'dropdown' }) do
      concat(
        content_tag(:div, class: 'avatar-dropdown-header') do
          concat(avatar_dropdown_header)
        end,
      )
      concat(avatar_dropdown_content)
      concat(avatar_dropdown_actions)
    end
  end

  def avatar_dropdown_header
    concat(avatar_image)
    content_tag(:div) do
      concat(content_tag(:p, user.username))
      concat(content_tag(:p, user.email))
    end
  end

  def avatar_dropdown_content
    content_tag(:div, class: 'avatar-dropdown-content') do
      concat(avatar_link(:user, 'Profile', '#'))
    end
  end

  def avatar_dropdown_actions
    content_tag(:div, class: 'avatar-dropdown-actions') do
      concat(avatar_link(:right_from_bracket, 'Log out', destroy_user_session_path, method: :delete))
    end
  end

  def avatar_link(icon, title, path, method: nil)
    link_to(path, data: (method ? { turbo_method: method } : {}), class: 'avatar-link') do
      concat(fa_icon(icon))
      concat(title)
    end
  end

  def avatar_image
    image_tag(user.default_avatar_image, alt: 'User default avatar')
  end
end
