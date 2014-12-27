class AddRatingToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :rating, :decimal
  end
end
