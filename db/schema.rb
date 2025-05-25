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

ActiveRecord::Schema[8.0].define(version: 2025_05_25_234033) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "proponent_id", null: false
    t.string "street"
    t.string "number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zip_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proponent_id"], name: "index_addresses_on_proponent_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "proponent_id", null: false
    t.integer "contact_type", default: 1
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proponent_id"], name: "index_contacts_on_proponent_id"
  end

  create_table "proponents", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "cpf", null: false
    t.date "birth_date"
    t.decimal "salary", precision: 10, scale: 2
    t.decimal "inss_discount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_proponents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_proponents_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "proponents"
  add_foreign_key "contacts", "proponents"
end
