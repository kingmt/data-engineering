class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :item, index: true
      t.references :person, index: true
      t.references :address, index: true
      t.references :merchant, index: true

      t.integer :quantity

      t.timestamps
    end
  end
end
