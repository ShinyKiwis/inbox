# frozen_string_literal: true

class Notebook < ApplicationRecord
  include DecodableParamsConcern

  belongs_to :status
  belongs_to :owner, class_name: 'User'
  belongs_to :parent, class_name: 'Notebook', optional: true

  has_many :notes, dependent: :destroy
  has_many :notebooks, class_name: 'Notebook', foreign_key: 'parent_id'

  validates :name, presence: true, length: { maximum: 30 }

  scope :root, -> { where(parent_id: nil) }
  scope :active, -> { joins(:status).where.not(statuses: { name: Status::OPERATIONAL[:pending_for_delete] }) }

  def items
    [notes.active, notebooks.active].flat_map(&:itself)
      .sort_by { |item| [item.name ? 0 : 1, item.name || 0] }
  end

  def child_notebook?
    parent_id.present?
  end

  def outermost_parent
    current_notebook = self
    current_notebook = current_notebook.parent while current_notebook.parent.present?
    current_notebook
  end

  def all_notes
    subquery = <<-SQL.squish
      WITH RECURSIVE notebook_tree AS (
        SELECT id
        FROM notebooks
        WHERE id = :notebook_id
      UNION ALL
        SELECT n.id
        FROM notebooks n
        INNER JOIN notebook_tree nt ON nt.id = n.parent_id
      )
      SELECT id FROM notebook_tree
    SQL

    Note.where("notebook_id IN (#{subquery})", notebook_id: id)
  end
end
