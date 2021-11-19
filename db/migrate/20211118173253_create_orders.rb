class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :orderNumber
      t.date :date
      t.decimal :total, precision: 10, scale: 2
      t.boolean :active

      t.timestamps
    end
  end
end