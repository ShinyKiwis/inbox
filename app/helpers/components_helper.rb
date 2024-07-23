# frozen_string_literal: true

module ComponentsHelper
  def main_sidebar(&block)
    content_tag :div, class: 'main-sidebar' do
      capture(&block)
    end
  end

  def main_sidebar_item(path, action, icon)
    active_class = active_sidebar_item?(path) ? 'active' : ''
    link_to(path, class: "item #{active_class}") do
      concat(content_tag(:div, class: 'icon') do
        fa_icon(icon)
      end)
      concat(content_tag(:span, action))
    end
  end

  def sub_sidebar(&block)
    content = capture(&block).strip
    return if content.empty?

    content_tag :div, class: 'sub-sidebar' do     
      content.html_safe
    end
  end

  def sub_sidebar_item(current_controller)
    return unless active_sub_sidebar?(current_controller)

    render "#{current_controller}/sidebar"
  end

  def action_button(text, path, options = {})
    link_options = options.to_h
    link_options[:class] = "btn btn-#{options[:style]}"
    link_to path, link_options do
      concat fa_icon options[:icon] if options[:icon]
      concat text
    end
  end

  private

  def active_sidebar_item?(current_path)
    request.path == current_path || request.path.include?(current_path)
  end

  def active_sub_sidebar?(current_controller)
    controller_name == current_controller
  end
end
