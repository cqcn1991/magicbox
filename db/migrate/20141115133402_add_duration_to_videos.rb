class AddDurationToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :duration, :integer
    add_column :videos, :category, :string
  end
end
