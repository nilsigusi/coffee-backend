# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 0) do

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "paymethods", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "description"
  end

  create_table "transactions", force: :cascade do |t|
    t.float    "balance"
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "paymethod_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["paymethod_id"], name: "index_transactions_on_paymethod_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.string   "name"
    t.string   "cardnum"
    t.integer  "pin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["pin"], name: "index_users_on_pin", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end


  create_table "mobiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "nfc_card_number"
    t.string   "mobile_id"
    t.integer  "mobile_pin"
    t.index ["user_id"], name: "index_mobiles_on_user_id"
    t.index ["mobile_pin"], name: "index_mobiles_on_pin", unique: true

  end

end
