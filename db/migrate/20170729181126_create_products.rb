class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.money :price
      t.integer :inventory
      t.boolean :active

      t.timestamps
    end
  end
end
