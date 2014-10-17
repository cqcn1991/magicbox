class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url
      t.string :title
      t.string :source
      t.integer :likes
      t.integer :reply_number
      t.text :abstraction

      t.float :score
      t.string :avatar
      t.string :author_name


      t.timestamps
    end
  end
end
