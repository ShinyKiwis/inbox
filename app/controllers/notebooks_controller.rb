# frozen_string_literal: true

class NotebooksController < ApplicationController
  include DecodableParamsController
  helper_method :new_folder?

  DEFAULT_PARENT_ATTRIBUTES = ['owner_id', 'status_id'].freeze

  def index
  end

  def new
    @notebook = Notebook.new
  end

  def new_folder
    parent_notebook = Notebook.find(params[:notebook_id])
    @notebook = parent_notebook.notebooks.new
  end

  def show
    @notebook = Notebook.find(params[:id])
  end

  def create
    @notebook = Notebook.new(notebook_params)
    @notebook.owner = current_user
    @notebook.status = Status.find_by(name: Status::PRIVACY[:private])
    if @notebook.save
      respond_to do |format|
        format.turbo_stream
      end
    else
    puts "Failed to save notebook: #{@notebook.errors.full_messages.join(", ")}"
      render :new, status: :unprocessable_entity
    end
  end

  def create_folder
    parent_notebook = Notebook.find(params[:notebook_id])
    default_parent_attributes = parent_notebook.attributes.slice(*DEFAULT_PARENT_ATTRIBUTES)
    @notebook = parent_notebook.notebooks.build(default_parent_attributes.merge(notebook_params))

    if @notebook.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new_folder, status: :unprocessable_entity
    end
  end

  def delete
    notebook = Notebook.find(params[:notebook_id])
    notebook.status = Status.find_by(name: Status::OPERATIONAL[:pending_for_delete])
    notebook.save
  end

  private

  def notebook_params
    params.require(:notebook).permit(
      :name,
    )
  end

  def new_folder?
    request.path.include?('new_folder')
  end
end
