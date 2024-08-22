# frozen_string_literal: true

class NotesController < ApplicationController
  include DecodableParamsController

  def create
    @notebook = Notebook.find(params[:notebook_id])
    @note = @notebook.notes.create(status_id: @notebook.status_id)

    if @notebook.child_notebook?
      redirect_to notebook_note_path(@notebook.outermost_parent, @note)
    else
      redirect_to notebook_note_path(@notebook, @note)
    end
  end

  def show
    @notebook = Notebook.find(params[:notebook_id])
    @note = @notebook.all_notes.find(params[:id])

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    @notebook = Notebook.find(params[:notebook_id])
    @note = Note.find(params[:id])
    @note.assign_attributes(note_params)
    if @note.save
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def delete
    @notebook = Notebook.find(params[:notebook_id]).outermost_parent
    note = Note.find(params[:note_id])
    note.status = Status.find_by(name: Status::OPERATIONAL[:pending_for_delete])
    note.save

    if params[:current_path] == request.path.gsub!('/delete', '')
      respond_to do |format|
        format.turbo_stream { render 'notes/redirect', locals: { redirect_path: notebook_path(@notebook) } }
      end
    else
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  private

  def note_params
    params.require(:note).permit(
      :name,
      :content,
    )
  end
end
