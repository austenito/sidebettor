# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090502212944) do

  create_table "bet_conditions", :force => true do |t|
    t.string   "condition",    :null => false
    t.integer  "user_id",      :null => false
    t.integer  "bet_id",       :null => false
    t.integer  "bet_type_id",  :null => false
    t.integer  "bet_ratio_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bet_ratios", :force => true do |t|
    t.integer  "ratio",      :null => false
    t.integer  "bet_id",     :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bet_requests", :force => true do |t|
    t.boolean  "is_pending",   :null => false
    t.boolean  "has_accepted", :null => false
    t.integer  "bet_id",       :null => false
    t.integer  "user_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bet_statuses", :force => true do |t|
    t.boolean  "is_completed", :null => false
    t.integer  "bet_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bet_types", :force => true do |t|
    t.string   "bet_type",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bets", :force => true do |t|
    t.string   "title",      :null => false
    t.date     "end_date",   :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prize_categories", :force => true do |t|
    t.string   "prize_category", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prizes", :force => true do |t|
    t.string   "name",              :null => false
    t.integer  "bet_id",            :null => false
    t.integer  "prize_category_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
