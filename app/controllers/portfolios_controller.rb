# frozen_string_literal: true

class PortfoliosController < ApplicationController
  before_action :authenticate_user!

  def index    
    get_portfolio(current_user.id)
  end

  def show
    user_id = params[:id]
    @user = User.find(user_id)
    get_portfolio(user_id)
  end

  private 

  def get_portfolio(user_id)
    @total_value = 0
    @total_profit = 0
    @total_profit_percentage = 0
    @portfolios = Portfolio.includes(:coin).where(user_id: user_id)
    @portfolios.each do |portfolio|
      @total_value += (portfolio.total_quantity * portfolio.coin.current_price)
      @total_profit = @total_profit + (portfolio.total_quantity * portfolio.coin.current_price) - portfolio.total_cost
    end
    @total_profit_percentage = (@total_profit / 1_000_000) * 100
  end
end
