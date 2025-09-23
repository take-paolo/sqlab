class DropModelDatabasesAndTables < ActiveRecord::Migration[6.1]
  def up
    # Drop model_tables first (has foreign key to model_databases)
    drop_table :model_tables, if_exists: true

    # Drop model_databases table
    drop_table :model_databases, if_exists: true
  end

  def down
    # Recreate model_databases table first
    create_table :model_databases do |t|
      t.string :name, null: false
      t.timestamps
    end

    # Recreate model_tables table (with foreign key to model_databases)
    create_table :model_tables do |t|
      t.references :model_database, null: false, foreign_key: true
      t.string :name, null: false
      t.timestamps
    end
  end
end
