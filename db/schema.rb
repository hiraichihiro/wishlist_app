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

ActiveRecord::Schema[7.2].define(version: 2026_08_16_053850) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "savings", force: :cascade do |t|
    t.bigint "wish_id", null: false
    t.integer "amount"
    t.date "saved_at"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wish_id"], name: "index_savings_on_wish_id"
  end

  create_table "wishes", force: :cascade do |t|
    t.string "title"
    t.integer "target_amount"
    t.date "deadline"
    t.string "image_url"
    t.string "link_url"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "savings", "wishes"
end
