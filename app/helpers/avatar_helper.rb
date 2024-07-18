# frozen_string_literal: true

module AvatarHelper
  def avatar(options = {})
    @user = options[:user_id] ? User.find(options[:user_id]) : current_user
    content_tag :span, class: 'avatar' do
      concat avatar_image
      if options[:with_expander]
        concat(content_tag(:span, fa_icon(:angle_down), class: 'avatar-expander'))
        concat avatar_dropdown
      end
    end
  end

  def avatar_dropdown
    content_tag :div, class: 'avatar-dropdown' do
      concat(
        content_tag(:div, class: 'avatar-dropdown-header') do
          concat avatar_dropdown_header
        end
      )
      concat avatar_dropdown_content
      concat avatar_dropdown_actions
    end
  end

  def avatar_dropdown_header
    concat avatar_image
    content_tag(:div) do
      concat content_tag(:p, @user.username)
      concat content_tag(:p, @user.email)
    end
  end

  def avatar_dropdown_content
    content_tag :div, class: 'avatar-dropdown-content' do
      concat avatar_link(:bowl_food, "Rice", "#")
      concat avatar_link(:utensils, "Utensils", "#")
      concat avatar_link(:pizza_slice, "Pizza", "#")
      concat avatar_link(:fish, "Fish", "#")
    end
  end

  def avatar_dropdown_actions
    content_tag :div, class: 'avatar-dropdown-actions' do
      concat avatar_link(:right_from_bracket, 'Log out', destroy_user_session_path, method: :delete)
    end
  end

  def avatar_link(icon, title, path, method: nil)
    link_to path, data: (method ? { turbo_method: method } : {}), class: 'avatar-link' do
      concat fa_icon(icon)
      concat title
    end
  end

  def avatar_image
    @user.default_avatar_image.html_safe
  end
end
