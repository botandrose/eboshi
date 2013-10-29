class Baseline < ActiveRecord::Migration
  def change
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
    end

    create_table "line_items", :force => true do |t|
      t.integer  "client_id"
      t.integer  "user_id"
      t.datetime "start"
      t.datetime "finish"
      t.decimal  "rate",       :precision => 10, :scale => 2
      t.text     "notes"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "invoice_id"
      t.string   "type"
    end

    create_table "payments", :force => true do |t|
      t.integer  "invoice_id"
      t.decimal  "total",      :precision => 10, :scale => 2
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "users", :force => true do |t|
      t.string   "login"
      t.string   "email"
      t.string   "crypted_password",          :limit => 40
      t.string   "salt",                      :limit => 40
      t.datetime "created_at"
      t.datetime "updated_at"
      t.decimal  "rate",                                    :precision => 10, :scale => 2
      t.string   "color"
      t.string   "remember_token"
      t.datetime "remember_token_expires_at"
    end
  end
end
