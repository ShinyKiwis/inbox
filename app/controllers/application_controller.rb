# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  layout :layout_by_resource

  helper_method :notebooks

  private

  def layout_by_resource
    return false if turbo_frame_request?

    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def notebooks
    @notebooks ||= Notebook.where(owner_id: current_user)
  end
end
