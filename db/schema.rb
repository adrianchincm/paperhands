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

ActiveRecord::Schema.define(version: 2021_10_06_130827) do

  create_table "coins", force: :cascade do |t|
    t.string "coin_id", null: false
    t.string "symbol"
    t.string "name"
    t.string "image"
    t.float "current_price"
    t.integer "market_cap"
    t.integer "market_cap_rank"
    t.integer "fully_diluted_valuation"
    t.integer "total_volume"
    t.integer "high_24h"
    t.integer "low_24h"
    t.float "price_change_24h"
    t.float "price_change_percentage_24h"
    t.integer "market_cap_change_24h"
    t.float "market_cap_change_percentage_24h"
    t.integer "circulating_supply"
    t.integer "total_supply"
    t.integer "max_supply"
    t.integer "ath"
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

end
