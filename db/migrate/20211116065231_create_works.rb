class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description, null: false
      t.boolean :enabled, null: false, default: false
      t.boolean :published, null: false, default: false
      t.integer :order_number, null: false

      t.timestamps
    end

    add_index :works, :slug, unique: true
  end
end
