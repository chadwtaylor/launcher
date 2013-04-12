class AddPrimaryKeyToOrders < ActiveRecord::Migration

  def self.up
    add_column :orders, :id, :primary_key
  end

  def self.down
    remove_column :orders, :id
  end

end
