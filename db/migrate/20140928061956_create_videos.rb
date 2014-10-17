class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.string :title
      t.string :img_url
      t.string :source_id
      t.string :source
      t.integer :hits

      t.timestamps
    end
  end
end
