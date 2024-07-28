class CreateNotebooks < ActiveRecord::Migration[7.1]
  def change
    create_table :notebooks do |t|
      t.string :name
      t.integer :owner_id
      t.integer :notes_counter
      t.integer :status_id

      t.timestamps
    end

    add_foreign_key :notebooks, :users, column: :owner_id
    add_foreign_key :notebooks, :statuses, column: :status_id

    add_index :notebooks, :owner_id
    add_index :notebooks, :status_id
  end
end
