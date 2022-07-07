class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.integer :release_year
      t.integer :total_page, null: false
    end
  end
end
