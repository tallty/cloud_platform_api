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

ActiveRecord::Schema.define(version: 20170220083658) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "authentication_token",   limit: 30
    t.index ["authentication_token"], name: "index_admins_on_authentication_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "appointment_items", force: :cascade do |t|
    t.integer  "interface_document_id"
    t.integer  "appointment_id"
    t.string   "aasm_state"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "range"
    t.index ["appointment_id"], name: "index_appointment_items_on_appointment_id"
    t.index ["interface_document_id"], name: "index_appointment_items_on_interface_document_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "range"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "interface_documents", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "site"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "frequency",   default: 0
    t.string   "api_type"
  end

  create_table "interface_documents_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "interface_document_id"
    t.index ["interface_document_id"], name: "index_interface_documents_users_on_interface_document_id"
    t.index ["user_id"], name: "index_interface_documents_users_on_user_id"
  end

  create_table "interface_sorts", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interface_document_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "range"
    t.date     "end_time"
    t.index ["interface_document_id"], name: "index_records_on_interface_document_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "sms_tokens", force: :cascade do |t|
    t.string   "phone"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statis_infos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interface_document_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["interface_document_id"], name: "index_statis_infos_on_interface_document_id"
    t.index ["user_id"], name: "index_statis_infos_on_user_id"
  end

  create_table "user_documents", id: false, force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interface_document_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["interface_document_id"], name: "index_user_documents_on_interface_document_id"
    t.index ["user_id"], name: "index_user_documents_on_user_id"
  end

  create_table "user_infos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "nickname"
    t.string   "address"
    t.integer  "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
    t.index ["user_id"], name: "index_user_infos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "phone",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "authentication_token",   limit: 30
    t.string   "appkey"
    t.string   "appid"
    t.string   "company_name"
    t.string   "name"
    t.string   "email"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
