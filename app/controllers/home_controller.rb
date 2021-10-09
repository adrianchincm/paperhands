require "httparty"

class HomeController < ApplicationController
  def index
    # refresh_coins
    @coins = Coin.all
  end

  private 

  # leave it here just for debugging in the future
  def refresh_coins
    url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'
    response = HTTParty.get(url)    
    price_hash_map = response.parsed_response
    key_map = {id: 'coin_id'}
    
    price_hash_map.each do |coin|
      coin["coin_id"] = coin["id"]
      coin.except!("id", "roi")    
    end

    Coin.upsert_all(price_hash_map, unique_by: :coin_id)
  end
end
