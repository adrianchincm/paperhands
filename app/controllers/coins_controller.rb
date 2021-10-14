require "httparty"

class CoinsController < ApplicationController
    def show
        puts "TESTING TESTING SHOW"
        get_coin_details
    end

    private

    def get_coin_details
        coin = Coin.find(params[:id])
        url = "https://api.coingecko.com/api/v3/coins/#{coin.coin_id}?localization=false&tickers=false&community_data=false&developer_data=false&sparkline=false"

        response = HTTParty.get(url)
        coin_details = response.parsed_response
        puts coin_details

        @coin = coin_details
        market_data = @coin["market_data"]
        
        Coin.update(params[:id], 
            description: @coin["description"]["en"],
            block_time_in_minutes: @coin["block_time_in_minutes"],
            sentiment_votes_up_percentage: @coin["sentiment_votes_up_percentage"],
            sentiment_votes_down_percentage: @coin["sentiment_votes_down_percentage"],
            price_change_percentage_7d: market_data["price_change_percentage_7d"],
            price_change_percentage_14d: market_data["price_change_percentage_14d"],
            price_change_percentage_30d: market_data["price_change_percentage_30d"],
            price_change_percentage_60d: market_data["price_change_percentage_60d"],
            price_change_percentage_200d: market_data["price_change_percentage_200d"],
            price_change_percentage_1y: market_data["price_change_percentage_1y"],
        )        
    end
end
