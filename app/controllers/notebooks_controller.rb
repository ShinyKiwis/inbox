# frozen_string_literal: true

class NotebooksController < ApplicationController
  def index
    @notebooks = Notebook.where(owner_id: current_user)
  end

  def show
  end
end
