class AddDefaultAvatarImageToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :default_avatar_image, :string
  end
end
