class CreateModelTables < ActiveRecord::Migration[6.1]
  def change
    create_table :model_tables do |t|
      t.references :model_database, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end

    add_index :model_tables, [:name, :model_database_id], unique: true
  end
end
