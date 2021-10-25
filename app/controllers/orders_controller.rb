# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user.id)
    @last_week_orders = Order.where(user_id: current_user.id, created_at: 1.week.ago..)
    @two_weeks_ago_count = Order.where(user_id: current_user.id, created_at: 1.week.ago..2.week.ago).count
    @today_orders = Order.where(user_id: current_user.id,
                                created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @today_buy_orders = get_buy_orders(@today_orders)
    @today_sell_orders = get_sell_orders(@today_orders)
    get_buy_order_percentage
    puts "Last week order count : #{@last_week_orders.count}"
  end

  def create
    userId = params[:userId]
    coinId = params[:coinId]
    @user = User.find(userId)

    begin
      modify_user_balance(params)
    rescue StandardError => e
      return render json: { error: e }, status: 400
    end

    new_order = Order.create(
      user_id: userId,
      coin_id: coinId,
      price: params[:usdInput],
      quantity: params[:coinInput],
      order_type: params[:type]
    )

    update_portfolio(new_order)

    render json: new_order
  end

  private

  def modify_user_balance(params)
    price = params[:usdInput].to_f
    coin_id = params[:coinId].to_f
    user_id = params[:userId].to_f
    coin_value = params[:coinInput].to_f

    if params[:type] == 'BUY'
      deduct_user_balance(price)
    else
      add_user_balance(price, coin_id, user_id, coin_value)
    end
  end

  def deduct_user_balance(price)
    raise StandardError, 'You do not have sufficient cash balance' if @user.cash_balance < price

    @user.cash_balance = @user.cash_balance - price
    @user.save
  end

  def add_user_balance(price, coin_id, user_id, coin_value)
    portfolio = Portfolio.find_by(user_id: user_id, coin_id: coin_id)
    raise StandardError, 'You do not have any tokens to sell' if portfolio.nil?
    raise StandardError, 'You do not have sufficient tokens to sell' if portfolio.total_quantity < coin_value

    @user.cash_balance = @user.cash_balance + price
    @user.save
  end

  def update_portfolio(new_order)
    portfolio = Portfolio.find_by(user_id: new_order.user_id, coin_id: new_order.coin_id)

    if portfolio.nil?
      Portfolio.create(
        user_id: new_order.user_id,
        coin_id: new_order.coin_id,
        total_quantity: new_order.quantity,
        total_cost: new_order.price,
        average_price: new_order.price / new_order.quantity
      )
    elsif new_order.order_type == 'BUY'
      buy_order_update_portfolio(new_order, portfolio)
    else
      sell_order_update_portfolio(new_order, portfolio)
    end
  end

  def buy_order_update_portfolio(new_order, portfolio)
    portfolio.total_quantity = portfolio.total_quantity + new_order.quantity
    portfolio.total_cost = portfolio.total_cost + new_order.price
    portfolio.average_price = portfolio.total_cost / portfolio.total_quantity
    portfolio.save
  end

  def sell_order_update_portfolio(new_order, portfolio)
    portfolio.total_quantity = portfolio.total_quantity - new_order.quantity
    portfolio.total_cost = portfolio.total_cost - new_order.price
    portfolio.average_price = portfolio.total_cost / portfolio.total_quantity
    portfolio.save
  end

  def get_buy_orders(today_orders)
    total = 0
    today_orders.each do |order|
      total += 1 if order.order_type == 'BUY'
    end
    total
  end

  def get_sell_orders(today_orders)
    total = 0
    today_orders.each do |order|
      total += 1 if order.order_type == 'SELL'
    end
    total
  end

  def get_buy_order_percentage
    buy_total = 0
    sell_total = 0
    buy_order_total = 0
    sell_order_total = 0

    @today_orders.each do |order|
      buy_total += 1 if order.order_type == 'BUY'
      sell_total += 1 if order.order_type == 'SELL'
    end

    @last_week_orders.each do |order|
      buy_order_total += 1 if order.order_type == 'BUY'
      sell_order_total += 1 if order.order_type == 'SELL'
    end

    @seven_day_buy_order_average = (buy_order_total / 7.0).to_f.round(2)
    @buy_order_percentage = (buy_total - @seven_day_buy_order_average) * 100

    @seven_day_sell_order_average = (sell_order_total / 7.0).to_f.round(2)
    @sell_order_percentage = (sell_total - @seven_day_sell_order_average) * 100
  end
end
