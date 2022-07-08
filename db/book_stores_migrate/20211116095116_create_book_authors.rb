class CreateBookAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :book_authors do |t|
      t.references :book, null: false, foreign_key: true
      t.references :author, null:false, foreign_key: true
    end

    add_index :book_authors, [:book_id, :author_id], unique: true
  end
end
