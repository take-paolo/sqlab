# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_15_175333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "model_databases", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_model_databases_on_name", unique: true
  end

  create_table "model_tables", force: :cascade do |t|
    t.bigint "model_database_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["model_database_id"], name: "index_model_tables_on_model_database_id"
    t.index ["name", "model_database_id"], name: "index_model_tables_on_name_and_model_database_id", unique: true
  end

  add_foreign_key "model_tables", "model_databases"
end
