# frozen_string_literal: true

class NotesController < ApplicationController
  include DecodableParamsController

  def create
    @notebook = Notebook.find(params[:notebook_id])
    @note = @notebook.notes.create(status_id: @notebook.status_id)

    redirect_to notebook_note_path(@notebook, @note)
  end

  def show
    @notebook = Notebook.find(params[:notebook_id])
    @note = @notebook.notes.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    @note.assign_attributes(note_params)
    @note.save
  end

  private

  def note_params
    params.require(:note).permit(
      :name,
      :content,
    )
  end
end
