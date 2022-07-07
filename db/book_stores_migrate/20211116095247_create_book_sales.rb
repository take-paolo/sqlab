class CreateBookSales < ActiveRecord::Migration[6.1]
  def change
    create_table :book_sales do |t|
      t.references :book, null: false, foreign_key: true
      t.references :store, null:false, foreign_key: true
      t.integer :price, null: false
      t.integer :stock, null: false
      t.integer :figure, null: false
    end

    add_index :book_sales, [:book_id, :store_id], unique: true
  end
end
