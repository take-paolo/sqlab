class CreateModelDatabases < ActiveRecord::Migration[6.1]
  def change
    create_table :model_databases do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :model_databases, :name, unique: true
  end
end
