class AddReplyNumberToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :reply_number, :integer
    add_column :posts, :score, :float
  end
end
