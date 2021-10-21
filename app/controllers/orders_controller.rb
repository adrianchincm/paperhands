class OrdersController < ApplicationController    
    def index

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
            order_type: params[:type])

        update_portfolio(new_order)

        render json: new_order             
    end

    private 

    def modify_user_balance(params)        
        price = params[:usdInput].to_f
        coin_id = params[:coinId].to_f
        user_id = params[:userId].to_f
        coin_value = params[:coinInput].to_f

        if (params[:type] == 'BUY')
            deduct_user_balance(price)
        else
            add_user_balance(price, coin_id, user_id, coin_value)
        end
        
    end

    def deduct_user_balance(price)        
        raise StandardError.new "You do not have sufficient cash balance" if @user.cash_balance < price
    
        @user.cash_balance = @user.cash_balance - price
        @user.save        
    end

    def add_user_balance(price, coin_id, user_id, coin_value)
        portfolio = Portfolio.find_by(user_id: user_id, coin_id: coin_id)
        raise StandardError.new "You do not have any tokens to sell" if portfolio.nil?
        raise StandardError.new "You do not have sufficient tokens to sell" if portfolio.total_quantity < coin_value
        
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
                average_price: new_order.price / new_order.quantity,                
            )
        else
            if new_order.order_type == 'BUY'
                buy_order_update_portfolio(new_order, portfolio)
            else
                sell_order_update_portfolio(new_order, portfolio)            
            end
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
end