# frozen_string_literal: true

require 'sidekiq-scheduler'
require 'httparty'
require 'active_support'

class RefreshCoin
  include Sidekiq::Worker

  def perform
    url =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'
    response = HTTParty.get(url)
    price_hash_map = response.parsed_response

    price_hash_map.each do |coin|
      coin['coin_id'] = coin['id']
      coin.except!('id', 'roi')
    end

    Coin.upsert_all(price_hash_map, unique_by: :coin_id)
    puts "Refreshed coins , coins last_updated : #{price_hash_map.first['last_updated']}"
  end
end
