class ChangeIntegerLimitInOrders < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :phone, :integer, limit:8
  end
end
