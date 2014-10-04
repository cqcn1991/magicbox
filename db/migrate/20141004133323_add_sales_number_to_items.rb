class AddSalesNumberToItems < ActiveRecord::Migration
  def change
    add_column :items, :sales_number, :integer
  end
end
