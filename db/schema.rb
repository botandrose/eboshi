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

ActiveRecord::Schema.define(version: 20160409211139) do

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "client_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["client_id"], name: "index_assignments_on_client_id", using: :btree
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id", using: :btree

  create_table "budgets", force: :cascade do |t|
    t.integer  "client_id",  limit: 4
    t.string   "name",       limit: 255
    t.decimal  "total",                  precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "address",           limit: 255
    t.string   "city",              limit: 255
    t.string   "state",             limit: 255
    t.string   "zip",               limit: 255
    t.string   "country",           limit: 255
    t.string   "email",             limit: 255
    t.string   "contact",           limit: 255
    t.string   "phone",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name",      limit: 255
    t.string   "terms",             limit: 255
    t.text     "terms_explanation", limit: 65535
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "client_id",     limit: 4
    t.datetime "date"
    t.string   "project_name",  limit: 255
    t.boolean  "include_dates",             default: false, null: false
    t.boolean  "include_times",             default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "budget_id",     limit: 4
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "client_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "start"
    t.datetime "finish"
    t.decimal  "rate",                     precision: 10, scale: 2
    t.text     "notes",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invoice_id", limit: 4
    t.string   "type",       limit: 255
    t.integer  "timestamp",  limit: 8,                              default: 0
  end

  add_index "line_items", ["client_id"], name: "index_line_items_on_client_id", using: :btree
  add_index "line_items", ["invoice_id"], name: "index_line_items_on_invoice_id", using: :btree
  add_index "line_items", ["user_id"], name: "index_line_items_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "invoice_id", limit: 4
    t.decimal  "total",                precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["invoice_id"], name: "index_payments_on_invoice_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.string   "crypted_password",       limit: 255
    t.string   "password_salt",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "rate",                               precision: 10, scale: 2
    t.string   "color",                  limit: 255
    t.string   "persistence_token",      limit: 255
    t.integer  "login_count",            limit: 4
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip",          limit: 255
    t.string   "current_login_ip",       limit: 255
    t.integer  "last_client_id",         limit: 4
    t.boolean  "admin",                                                       default: false
    t.string   "logo_file_name",         limit: 255
    t.string   "logo_content_type",      limit: 255
    t.integer  "logo_file_size",         limit: 4
    t.datetime "logo_updated_at"
    t.string   "signature_file_name",    limit: 255
    t.string   "signature_content_type", limit: 255
    t.integer  "signature_file_size",    limit: 4
    t.datetime "signature_updated_at"
    t.string   "business_name",          limit: 255
    t.string   "business_email",         limit: 255
    t.string   "address",                limit: 255
    t.string   "address2",               limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "zip",                    limit: 255
    t.boolean  "show_summaries",                                              default: true
  end

  add_index "users", ["last_client_id"], name: "index_users_on_last_client_id", using: :btree

end
