# frozen_string_literal: true

require 'sidekiq-scheduler'
require 'active_support'

class RefreshLeaderboard
  include Sidekiq::Worker

  def perform
    users = User.all
    users.each do |user|
      portfolios = Portfolio.where(user_id: user.id)
      total_cash = user.cash_balance
      total_orders = user.orders.count
      total_crypto = 0
      total_profit = 0
      total_profit_percentage = 0

      portfolios.each do |portfolio|
        total_crypto += (portfolio.total_quantity * portfolio.coin.current_price)
        total_profit += (portfolio.total_quantity * portfolio.coin.current_price) - portfolio.total_cost
      end
      total_profit_loss_percentage = (total_profit / 1_000_000) * 100

      total_net_worth = total_cash + total_crypto

      leaderboard_hash = {
        user_id: user.id.to_i,
        total_cash: total_cash,
        total_crypto: total_crypto,
        total_profit_loss_percentage: total_profit_loss_percentage,
        total_net_worth: total_net_worth,
        orders: total_orders
      }

      Leaderboard.upsert(
        leaderboard_hash,
        unique_by: :user_id
      )
    end
    puts "Leaderboard last synced at #{Time.now.strftime('%I:%M:%S %Z %z')}"
  end
end
