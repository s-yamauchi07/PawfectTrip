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

ActiveRecord::Schema[7.0].define(version: 2023_08_02_070414) do
  create_table "itineraries", charset: "utf8", force: :cascade do |t|
    t.datetime "date", null: false
    t.string "place", null: false
    t.integer "transportation_id", null: false
    t.text "memo"
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_itineraries_on_plan_id"
  end

  create_table "pets", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "breed", null: false
    t.integer "size_id", null: false
    t.date "birthday", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "plans", charset: "utf8", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "departure_date", null: false
    t.datetime "return_date", null: false
    t.integer "departure_id", null: false
    t.integer "destination_id", null: false
    t.integer "companion_id", null: false
    t.bigint "dog_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_id"], name: "index_plans_on_dog_id"
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "is_deleted", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "itineraries", "plans"
  add_foreign_key "pets", "users"
end
