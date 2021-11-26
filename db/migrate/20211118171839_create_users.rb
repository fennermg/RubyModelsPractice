class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :lastName, null: false
      t.date :birthDate, null: false
      t.string :password_digest, null: false
      t.boolean :active, null: false, default: true
      t.string :email, null: false
      t.timestamps
    end

  end
end
