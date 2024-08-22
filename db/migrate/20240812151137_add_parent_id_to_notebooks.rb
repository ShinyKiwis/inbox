class AddParentIdToNotebooks < ActiveRecord::Migration[7.1]
  def change
    add_column :notebooks, :parent_id, :integer
    add_foreign_key :notebooks, :notebooks, column: :parent_id
  end
end
