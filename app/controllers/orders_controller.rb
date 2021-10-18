class OrdersController < ApplicationController    
    def index

    end

    def create
        begin
            check_and_deduct_user_balance(params)
        rescue StandardError => e
            return render json: { error: e }, status: 400
        end    
        
        new_order = Order.create(
            user_id: params[:userId],
            coin_id: params[:coinId],
            price: params[:usdInput],
            quantity: params[:coinInput],
            order_type: params[:type])

        render json: new_order    
             
    end

    private 

    def check_and_deduct_user_balance(params)
        userId = params[:userId]
        price = params[:usdInput].to_f
        user = User.find(userId)
        if (user.cash_balance < price)
            raise StandardError.new "You do not have sufficient cash balance"
        else            
            user.cash_balance = user.cash_balance - price
            user.save
        end
    end
end