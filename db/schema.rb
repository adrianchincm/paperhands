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

ActiveRecord::Schema.define(version: 2021_10_11_141239) do

  create_table "coins", force: :cascade do |t|
    t.string "coin_id"
    t.string "symbol"
    t.string "name"
    t.string "image"
    t.float "current_price"
    t.bigint "market_cap"
    t.bigint "market_cap_rank"
    t.bigint "fully_diluted_valuation"
    t.bigint "total_volume"
    t.bigint "high_24h"
    t.bigint "low_24h"
    t.float "price_change_24h"
    t.float "price_change_percentage_24h"
    t.bigint "market_cap_change_24h"
    t.float "market_cap_change_percentage_24h"
    t.bigint "circulating_supply"
    t.bigint "total_supply"
    t.bigint "max_supply"
    t.bigint "ath"
    t.float "ath_change_percentage"
    t.datetime "ath_date"
    t.float "atl"
    t.float "atl_change_percentage"
    t.datetime "atl_date"
    t.datetime "last_updated"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coin_id"], name: "index_coins_on_coin_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
