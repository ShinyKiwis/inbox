# frozen_string_literal: true

class NotebooksController < ApplicationController
  include DecodableParamsController

  def index
  end

  def new
    @notebook = Notebook.new
  end

  def show
    @notebook = Notebook.find(params[:id])
  end

  def create
    @notebook = Notebook.new(notebook_params)
    @notebook.root = true
    @notebook.owner = current_user
    @notebook.status = Status.find_by(name: 'private')
    if @notebook.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def notebook_params
    params.require(:notebook).permit(
      :name,
      :status_id,
    )
  end
end
