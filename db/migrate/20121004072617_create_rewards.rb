class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.integer :index
      t.integer :amount
      t.string :subject
      t.string :summary
      t.integer :backers_limit
      t.boolean :tshirt_included, default:false
      t.boolean :is_shipable, default:true
      t.timestamps
    end
  end
end
