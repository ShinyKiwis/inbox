# frozen_string_literal: true

module ApplicationHelper
  AUTH_PATHS = %i[new_user_session new_user_registration new_user_password].freeze
  def render_header
    render 'layouts/header' unless current_page_any?(AUTH_PATHS)
  end

  private

  def current_page_any?(paths)
    paths.any? { |path| current_page?(path) }
  end
end
