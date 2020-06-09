# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_09_091122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.datetime "date_start"
    t.datetime "date_end"
    t.bigint "user_id"
    t.bigint "activity_type_id"
    t.integer "payment_type"
    t.integer "cost"
    t.string "short_description"
    t.text "description"
    t.integer "age_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "personal_page_id"
    t.string "name"
    t.string "slug"
    t.index ["activity_type_id"], name: "index_activities_on_activity_type_id"
    t.index ["personal_page_id"], name: "index_activities_on_personal_page_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "activities_categories", id: false, force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.bigint "category_id", null: false
  end

  create_table "activity_types", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "plural"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "categories_personal_pages", id: false, force: :cascade do |t|
    t.bigint "personal_page_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id", "personal_page_id"], name: "index_category_ppage"
    t.index ["personal_page_id", "category_id"], name: "index_ppage_category"
  end

  create_table "cc_confirmations", force: :cascade do |t|
    t.string "transaction_id"
    t.string "mnt_transaction_id"
    t.string "amount"
    t.integer "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_id"], name: "index_cc_confirmations_on_transaction_id", unique: true
    t.index ["user_id"], name: "index_cc_confirmations_on_user_id"
  end

  create_table "donates", force: :cascade do |t|
    t.bigint "personal_page_id"
    t.integer "amount"
    t.integer "status"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personal_page_id"], name: "index_donates_on_personal_page_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "target_id"
    t.string "target_type"
    t.integer "status"
    t.string "transaction_id"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_id"], name: "index_payments_on_transaction_id", unique: true
  end

  create_table "personal_pages", force: :cascade do |t|
    t.bigint "user_id"
    t.string "nickname"
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "short_description"
    t.index ["nickname"], name: "index_personal_pages_on_nickname", unique: true
    t.index ["user_id"], name: "index_personal_pages_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.text "text"
    t.string "slug"
    t.string "seo_title"
    t.string "seo_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "surname"
    t.string "midname"
    t.string "phone"
    t.string "inn"
    t.text "about"
    t.string "payment_token"
    t.integer "role"
    t.float "balance"
    t.date "dob"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "withdrawals", force: :cascade do |t|
    t.float "amount"
    t.string "client_transaction"
    t.string "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_withdrawals_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "activity_types"
  add_foreign_key "activities", "personal_pages"
  add_foreign_key "activities", "users"
  add_foreign_key "cc_confirmations", "users"
  add_foreign_key "donates", "personal_pages"
  add_foreign_key "personal_pages", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "withdrawals", "users"
end
