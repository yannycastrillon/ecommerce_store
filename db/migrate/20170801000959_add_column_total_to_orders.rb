class AddColumnTotalToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :total, :money
  end
end
