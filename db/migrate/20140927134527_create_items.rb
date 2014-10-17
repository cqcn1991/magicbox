class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :url
      t.string :title
      t.string :img_url
      t.string :taobao_id
      t.decimal :price
      t.belongs_to :shop, index: true
      t.integer :sales_number

      t.timestamps
    end
  end
end
