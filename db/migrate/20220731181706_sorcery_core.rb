class SorceryCore < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :role, null:false, default: 0
      t.string :crypted_password
      t.string :salt

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
