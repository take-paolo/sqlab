class CreatePractices < ActiveRecord::Migration[6.1]
  def change
    create_table :practices do |t|
      t.references :chapter, null:false, foreign_key: true
      t.string :name, null: false
      t.text :question, null: false
      t.text :answer, null: false
      t.integer :sample_database_id, null:false
      t.boolean :display_er_diagram, null: false, default: true
      t.boolean :enabled, null: false, default: false
      t.boolean :published, null: false, default: false
      t.boolean :requires_auth, null: false, default: true
      t.integer :order_number, null: false

      t.timestamps
    end
  end
end
