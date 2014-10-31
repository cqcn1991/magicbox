class AddSelectedToPostsAndVideos < ActiveRecord::Migration
  def change
    add_column :posts, :selected, :boolean
    add_column :videos, :selected, :boolean
  end
end
