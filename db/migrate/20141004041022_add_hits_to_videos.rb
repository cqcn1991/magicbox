class AddHitsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :hits, :integer
  end
end
