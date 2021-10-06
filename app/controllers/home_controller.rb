require "httparty"

class HomeController < ApplicationController
  def index


    url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'
    response = HTTParty.get(url)    
    price = response.parsed_response.to_a
    p price[0]["id"]
  end
end
