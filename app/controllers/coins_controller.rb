require 'httparty'

class CoinsController < ApplicationController
  def show
    get_current_holdings
    get_coin_details    
  end

  private

  def get_current_holdings
    @portfolio = Portfolio.find_by(user_id: current_user.id, coin_id: params[:id])
  end

  def get_coin_details
    coin = Coin.find(params[:id])
    url =
      "https://api.coingecko.com/api/v3/coins/#{coin.coin_id}?localization=false&tickers=false&community_data=false&developer_data=false&sparkline=false"

    response = HTTParty.get(url)
    coin_details = response.parsed_response    

    @coin = coin_details
    market_data = @coin['market_data']

    Coin.update(
      params[:id],      
      block_time_in_minutes: @coin['block_time_in_minutes'],
      sentiment_votes_up_percentage: @coin['sentiment_votes_up_percentage'],
      sentiment_votes_down_percentage: @coin['sentiment_votes_down_percentage'],
      price_change_percentage_7d: market_data['price_change_percentage_7d'],
      price_change_percentage_14d: market_data['price_change_percentage_14d'],
      price_change_percentage_30d: market_data['price_change_percentage_30d'],
      price_change_percentage_60d: market_data['price_change_percentage_60d'],
      price_change_percentage_200d: market_data['price_change_percentage_200d'],
      price_change_percentage_1y: market_data['price_change_percentage_1y']
    )
  end
end
