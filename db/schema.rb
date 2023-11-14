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

ActiveRecord::Schema[7.0].define(version: 2023_11_14_032152) do
  create_table "active_storage_attachments", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", charset: "utf8", force: :cascade do |t|
    t.text "comment", null: false
    t.bigint "user_id", null: false
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_comments_on_plan_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "hotel_likes", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "index_hotel_likes_on_hotel_id"
    t.index ["user_id"], name: "index_hotel_likes_on_user_id"
  end

  create_table "hotels", charset: "utf8", force: :cascade do |t|
    t.integer "hotel_num", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "itineraries", charset: "utf8", force: :cascade do |t|
    t.datetime "date", null: false
    t.string "place", null: false
    t.integer "transportation_id", null: false
    t.text "memo"
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat"
    t.float "lng"
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

  create_table "plan_likes", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_plan_likes_on_plan_id"
    t.index ["user_id"], name: "index_plan_likes_on_user_id"
  end

  create_table "plan_tags", charset: "utf8", force: :cascade do |t|
    t.bigint "plan_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id", "tag_id"], name: "index_plan_tags_on_plan_id_and_tag_id", unique: true
    t.index ["plan_id"], name: "index_plan_tags_on_plan_id"
    t.index ["tag_id"], name: "index_plan_tags_on_tag_id"
  end

  create_table "plans", charset: "utf8", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "departure_date", null: false
    t.datetime "return_date", null: false
    t.integer "departure_id", null: false
    t.integer "destination_id", null: false
    t.integer "companion_id", null: false
    t.bigint "pet_id", null: false
    t.string "tag"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_plans_on_pet_id"
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "sns_creadentials", charset: "utf8", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_creadentials_on_user_id"
  end

  create_table "tags", charset: "utf8", force: :cascade do |t|
    t.string "tag_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "plans"
  add_foreign_key "comments", "users"
  add_foreign_key "hotel_likes", "hotels"
  add_foreign_key "hotel_likes", "users"
  add_foreign_key "itineraries", "plans"
  add_foreign_key "pets", "users"
  add_foreign_key "plan_likes", "plans"
  add_foreign_key "plan_likes", "users"
  add_foreign_key "plan_tags", "plans"
  add_foreign_key "plan_tags", "tags"
  add_foreign_key "sns_creadentials", "users"
end
