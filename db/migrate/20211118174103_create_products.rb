class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :quantity, null: false
      t.boolean :active, null: false

      t.timestamps
    end
  end
end
