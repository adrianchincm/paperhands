# frozen_string_literal: true

class CreateCoins < ActiveRecord::Migration[6.1]
  def change
    create_table :coins do |t|
      t.string :coin_id, index: { unique: true }
      t.string :symbol
      t.string :name
      t.string :image
      t.float :current_price
      t.bigint :market_cap
      t.bigint :market_cap_rank
      t.bigint :fully_diluted_valuation
      t.bigint :total_volume
      t.bigint :high_24h
      t.bigint :low_24h
      t.float :price_change_24h
      t.float :price_change_percentage_24h
      t.bigint :market_cap_change_24h
      t.float :market_cap_change_percentage_24h
      t.bigint :circulating_supply
      t.bigint :total_supply
      t.bigint :max_supply
      t.bigint :ath
      t.float :ath_change_percentage
      t.datetime :ath_date
      t.float :atl
      t.float :atl_change_percentage
      t.datetime :atl_date
      t.datetime :last_updated

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
