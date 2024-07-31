# frozen_string_literal: true

module ComponentsHelper
  def main_sidebar(&block)
    content_tag(:div, class: 'main-sidebar') do
      capture(&block)
    end
  end

  def main_sidebar_item(path, action, icon)
    active_class = active_sidebar_item?(path) ? 'active' : ''
    link_to(path, class: "item #{active_class}") do
      concat(content_tag(:div, class: 'icon') do
        fa_icon(icon)
      end)
      concat content_tag(:span, action)
    end
  end

  def sub_sidebar(&block)
    content = capture(&block).strip
    return if content.empty?

    content_tag(:div, content.html_safe, class: 'sub-sidebar')
  end

  def sub_sidebar_item(current_controller)
    return unless active_sub_sidebar?(current_controller)

    render "#{current_controller}/sidebar"
  end

  def action_button(text, path, options = {})
    link_options = {}
    link_options[:class] = "btn btn-#{options[:style]}"
    link_options[:data] = options[:data]
    link_to(path, link_options) do
      concat fa_icon options[:icon] if options[:icon]
      concat text
    end
  end

  def modal(options = {}, &block)
    header = content_tag :div, class: 'modal-header' do
      concat content_tag :span, options[:title], class: 'modal-title' if options[:title].present?
      concat(content_tag(:span, fa_icon('xmark'), data: { action: 'click->modal#toggle' }))
    end
    description = content_tag :p, options[:description], class: 'modal-description' if options[:description]
    body = content_tag :div, class: 'modal-body' do
      capture(&block)
    end

    content_tag :div, class: 'overlay', data: { controller: 'modal', modal_target: 'modal' } do
      concat(content_tag(:div, class: 'modal') do
        concat header.html_safe
        concat description.html_safe
        concat body.html_safe
      end)
    end
  end

  def modal_actions(&block)
    content_tag :div, class: 'modal-actions' do
      concat capture(&block)
    end
  end

  def notebook_item(notebook)
    active_class = request.path == notebook_path(notebook) ? 'active' : nil
    link_to notebook_path(notebook), class: "notebook #{active_class}" do
      concat content_tag(:span, '', class: 'active-indicator') if active_class
      concat fa_icon 'book'
      concat content_tag(:span, notebook.name)
    end
  end

  def context_menu(context_menu_id, &block)
    data_options = {
      'context-menu-target': 'menu',
      'context-menu-id': context_menu_id,
    }
    content_tag :div, class: 'context-menu hide', data: data_options do
      capture(&block)
    end
  end

  def context_menu_item(path, text, icon, options = {})
    link_to path, class: 'context-menu-item', data: options[:data] do
      concat fa_icon icon
      concat content_tag(:span, text)
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
