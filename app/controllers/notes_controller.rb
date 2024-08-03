# frozen_string_literal: true

class NotesController < ApplicationController
  include DecodableParamsController

  def create
    @notebook = Notebook.find(params[:notebook_id])
    @note = @notebook.notes.create(status_id: @notebook.status_id)
  end

  def show
    @notebook = Notebook.find(params[:notebook_id])
    @note = @notebook.notes.find(params[:id])
  end
end
