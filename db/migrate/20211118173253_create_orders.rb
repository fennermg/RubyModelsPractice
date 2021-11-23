class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :orderNumber, null: false
      t.date :date, null: false
      t.decimal :total, precision: 10, scale: 2, null: false,default: 0.0
      t.boolean :active, null: false,default: true

      t.timestamps

      t.belongs_to :user, foreign_key: true
    end
  end
end
