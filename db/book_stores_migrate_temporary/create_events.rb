class CreateEvents < Samples::TemporaryMigration
  def create_temporary_table
    create_table :events, temporary: true, force: true do |t|
      t.string :name, null: false
      t.integer :max_num, null: false
    end
  end
end
