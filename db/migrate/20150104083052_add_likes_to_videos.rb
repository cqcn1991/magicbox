class AddLikesToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :likes, :integer
  end
end
