# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!
  def dashboard
  end
end
