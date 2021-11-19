class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.decimal :total, precision: 10, scale: 2
      t.integer :quantity

      t.timestamps
    end
  end
end