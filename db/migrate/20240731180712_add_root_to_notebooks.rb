class AddRootToNotebooks < ActiveRecord::Migration[7.1]
  def change
    add_column :notebooks, :root, :boolean
  end
end
