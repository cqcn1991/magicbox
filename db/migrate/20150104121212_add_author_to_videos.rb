class AddAuthorToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :author, :string
  end
end
