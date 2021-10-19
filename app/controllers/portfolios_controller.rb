class PortfoliosController < ApplicationController    
        
    def index
        @total_value = 0
        @total_profit = 0
        @total_profit_percentage = 0
        @portfolios = Portfolio.includes(:coin).where(user_id: current_user.id)
        @portfolios.each { |portfolio|
            @total_value = @total_value + (portfolio.total_quantity * portfolio.coin.current_price)
            @total_profit = @total_profit + (portfolio.total_quantity * portfolio.coin.current_price) - portfolio.total_cost
            @total_profit_percentage = ((portfolio.coin.current_price - portfolio.average_price)/portfolio.coin.current_price) * 100
        }
        # puts "PORTFOLIO : #{@portfolios[0].coin.name}"
                
    end

end