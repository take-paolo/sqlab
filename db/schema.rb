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

ActiveRecord::Schema.define(version: 2021_11_16_065620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chapters", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "name", null: false
    t.integer "order_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["work_id"], name: "index_chapters_on_work_id"
  end

  create_table "practices", force: :cascade do |t|
    t.bigint "chapter_id", null: false
    t.string "name", null: false
    t.text "question", null: false
    t.text "answer", null: false
    t.string "sample_database_uid", null: false
    t.boolean "display_er_diagram", default: true, null: false
    t.boolean "enabled", default: false, null: false
    t.boolean "published", default: false, null: false
    t.boolean "requires_auth", default: true, null: false
    t.integer "order_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chapter_id"], name: "index_practices_on_chapter_id"
  end

  create_table "sample_tables", force: :cascade do |t|
    t.bigint "practice_id", null: false
    t.string "uid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["practice_id", "uid"], name: "index_sample_tables_on_practice_id_and_uid", unique: true
    t.index ["practice_id"], name: "index_sample_tables_on_practice_id"
  end

  create_table "works", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.text "description", null: false
    t.boolean "enabled", default: false, null: false
    t.boolean "published", default: false, null: false
    t.integer "order_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_works_on_slug", unique: true
  end

  add_foreign_key "chapters", "works"
  add_foreign_key "practices", "chapters"
  add_foreign_key "sample_tables", "practices"
end
