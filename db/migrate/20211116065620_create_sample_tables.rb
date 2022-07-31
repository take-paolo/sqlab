class CreateSampleTables < ActiveRecord::Migration[6.1]
  def change
    create_table :sample_tables do |t|
      t.references :practice, null:false, foreign_key: true
      t.integer :uid, null:false

      t.timestamps
    end

    add_index :sample_tables, [:practice_id, :uid], unique: true
  end
end
