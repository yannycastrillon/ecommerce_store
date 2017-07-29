class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :email
      t.string :bill_firstname
      t.string :bill_lastname
      t.string :bill_address1
      t.string :bill_address2
      t.string :bill_city
      t.string :bill_state
      t.integer :bill_zipcode
      t.integer :phone
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
