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

ActiveRecord::Schema.define(version: 20180207130226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.bigint "treatment_phase_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["treatment_phase_id"], name: "index_albums_on_treatment_phase_id"
  end

  create_table "clinics", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.bigint "district_id"
    t.string "address"
    t.string "website"
    t.string "facebook"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_clinics_on_district_id"
  end

  create_table "districts", force: :cascade do |t|
    t.bigint "province_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province_id"], name: "index_districts_on_province_id"
  end

  create_table "experts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.string "title"
    t.string "workplace"
    t.string "facebook_url"
    t.string "address"
    t.bigint "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_experts_on_district_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "album_id"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_images_on_album_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "treatment_phase_id"
    t.bigint "sender_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sender_id"], name: "index_messages_on_sender_id"
    t.index ["treatment_phase_id"], name: "index_messages_on_treatment_phase_id"
  end

  create_table "patient_records", force: :cascade do |t|
    t.bigint "clinic_id"
    t.date "start_date"
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.integer "gender"
    t.bigint "district_id"
    t.string "phone_number"
    t.string "email"
    t.string "fax"
    t.string "doctor"
    t.string "profile_photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.index ["clinic_id"], name: "index_patient_records_on_clinic_id"
    t.index ["district_id"], name: "index_patient_records_on_district_id"
  end

  create_table "price_lists", force: :cascade do |t|
    t.bigint "patient_record_id"
    t.string "item"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_record_id"], name: "index_price_lists_on_patient_record_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatment_phases", force: :cascade do |t|
    t.bigint "patient_record_id"
    t.string "name"
    t.date "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["patient_record_id"], name: "index_treatment_phases_on_patient_record_id"
  end

  create_table "treatment_plan_files", force: :cascade do |t|
    t.string "source"
    t.bigint "treatment_phase_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["treatment_phase_id"], name: "index_treatment_plan_files_on_treatment_phase_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "avatar"
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.integer "gender"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "clinic_id"
    t.index ["clinic_id"], name: "index_user_profiles_on_clinic_id"
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "username"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "albums", "treatment_phases"
  add_foreign_key "clinics", "districts"
  add_foreign_key "districts", "provinces"
  add_foreign_key "experts", "districts"
  add_foreign_key "images", "albums"
  add_foreign_key "messages", "treatment_phases"
  add_foreign_key "patient_records", "clinics"
  add_foreign_key "patient_records", "districts"
  add_foreign_key "price_lists", "patient_records"
  add_foreign_key "treatment_phases", "patient_records"
  add_foreign_key "treatment_plan_files", "treatment_phases"
  add_foreign_key "user_profiles", "clinics"
  add_foreign_key "user_profiles", "users"
end
