class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.money :unit_price
      t.integer :quantity
      t.money :total_price

      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
