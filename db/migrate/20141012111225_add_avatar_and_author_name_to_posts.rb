class AddAvatarAndAuthorNameToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :avatar, :string
    add_column :posts, :author_name, :string
  end
end
