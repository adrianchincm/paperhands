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

ActiveRecord::Schema.define(version: 2021_10_27_150431) do

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
    t.string "description"
    t.bigint "block_time_in_minutes"
    t.float "sentiment_votes_up_percentage"
    t.float "sentiment_votes_down_percentage"
    t.float "price_change_percentage_7d"
    t.float "price_change_percentage_14d"
    t.float "price_change_percentage_30d"
    t.float "price_change_percentage_60d"
    t.float "price_change_percentage_200d"
    t.float "price_change_percentage_1y"
    t.index ["coin_id"], name: "index_coins_on_coin_id", unique: true
  end

  create_table "leaderboards", force: :cascade do |t|
    t.integer "user_id"
    t.float "total_cash"
    t.float "total_crypto"
    t.float "total_profit_loss_percentage"
    t.float "total_net_worth"
    t.integer "orders"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_leaderboards_on_user_id", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "coin_id", null: false
    t.float "price", null: false
    t.decimal "quantity", null: false
    t.string "order_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coin_id"
    t.float "total_quantity"
    t.float "total_cost"
    t.float "average_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.float "cash_balance"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
