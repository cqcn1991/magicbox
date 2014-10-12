class AddAbstractionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :abstraction, :text
  end
end
