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

ActiveRecord::Schema.define(version: 2016_03_20_022237) do

  create_table "assignments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["client_id"], name: "index_assignments_on_client_id"
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "budgets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "client_id"
    t.string "name"
    t.decimal "total", precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.string "email"
    t.string "contact"
    t.string "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "client_id"
    t.datetime "date"
    t.string "project_name"
    t.boolean "include_dates", default: false, null: false
    t.boolean "include_times", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "budget_id"
    t.index ["client_id"], name: "index_invoices_on_client_id"
  end

  create_table "line_items", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "client_id"
    t.integer "user_id"
    t.datetime "start"
    t.datetime "finish"
    t.decimal "rate", precision: 10, scale: 2
    t.text "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "invoice_id"
    t.string "type"
    t.bigint "timestamp", default: 0
    t.index ["client_id"], name: "index_line_items_on_client_id"
    t.index ["invoice_id"], name: "index_line_items_on_invoice_id"
    t.index ["user_id"], name: "index_line_items_on_user_id"
  end

  create_table "payments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "invoice_id"
    t.decimal "total", precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "crypted_password"
    t.string "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "rate", precision: 10, scale: 2
    t.string "color"
    t.string "persistence_token"
    t.integer "login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string "last_login_ip"
    t.string "current_login_ip"
    t.integer "last_client_id"
    t.boolean "admin", default: false
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
    t.string "signature_file_name"
    t.string "signature_content_type"
    t.integer "signature_file_size"
    t.datetime "signature_updated_at"
    t.string "business_name"
    t.string "business_email"
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.boolean "show_summaries", default: true
    t.index ["last_client_id"], name: "index_users_on_last_client_id"
  end

end
