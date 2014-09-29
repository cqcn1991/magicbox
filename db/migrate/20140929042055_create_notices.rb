class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.text :content
      t.boolean :pinned

      t.timestamps
    end
  end
end
