class CreateCoins < ActiveRecord::Migration[6.1]
  def change
    create_table :coins do |t|
      t.string :coin_id, index: { unique: true }
      t.string :symbol
      t.string :name
      t.string :image
      t.float :current_price
      t.integer :market_cap
      t.integer :market_cap_rank
      t.integer :fully_diluted_valuation
      t.integer :total_volume
      t.integer :high_24h
      t.integer :low_24h
      t.float :price_change_24h
      t.float :price_change_percentage_24h
      t.integer :market_cap_change_24h
      t.float :market_cap_change_percentage_24h
      t.integer :circulating_supply
      t.integer :total_supply
      t.integer :max_supply
      t.integer :ath
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
