class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.string :name
      t.jsonb :content
      t.integer :notebook_id
      t.integer :status_id

      t.timestamps
    end
  end
end
