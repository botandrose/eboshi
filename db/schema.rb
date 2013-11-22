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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131122211732) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "assignments", ["client_id"], :name => "index_assignments_on_client_id"
  add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "email"
    t.string   "contact"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "client_id"
    t.datetime "date"
    t.string   "project_name"
    t.boolean  "include_dates", :default => false, :null => false
    t.boolean  "include_times", :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoices", ["client_id"], :name => "index_invoices_on_client_id"

  create_table "line_items", :force => true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.datetime "start"
    t.datetime "finish"
    t.decimal  "rate",                    :precision => 10, :scale => 2
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invoice_id"
    t.string   "type"
    t.integer  "timestamp",  :limit => 8,                                :default => 0
  end

  add_index "line_items", ["client_id"], :name => "index_line_items_on_client_id"
  add_index "line_items", ["invoice_id"], :name => "index_line_items_on_invoice_id"
  add_index "line_items", ["user_id"], :name => "index_line_items_on_user_id"

  create_table "payments", :force => true do |t|
    t.integer  "invoice_id"
    t.decimal  "total",      :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["invoice_id"], :name => "index_payments_on_invoice_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "rate",                   :precision => 10, :scale => 2
    t.string   "color"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.integer  "last_client_id"
    t.boolean  "admin",                                                 :default => false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "signature_file_name"
    t.string   "signature_content_type"
    t.integer  "signature_file_size"
    t.datetime "signature_updated_at"
    t.string   "business_name"
    t.string   "business_email"
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "show_summaries",                                        :default => true
  end

  add_index "users", ["last_client_id"], :name => "index_users_on_last_client_id"

end
