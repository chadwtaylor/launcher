class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders, :id => false do |t|
      t.integer :person_id
      t.integer :reward_id
      t.integer :shipping_address_id
      t.string  :stripe_customer
      t.integer :reward_amount_paid
      t.integer :shipping_amount_paid
      t.integer :contribution_amount
      t.string :tshirt_size
      t.timestamps
    end
  end
end
