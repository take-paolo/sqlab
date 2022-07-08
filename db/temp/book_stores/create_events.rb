class CreateEvents < Samples::Collections::TempMigration
  def temp_up
    create_table :events, temporary: true, force: true do |t|
      t.string :name, null: false
      t.integer :max_num, null: false
    end
  end
end
