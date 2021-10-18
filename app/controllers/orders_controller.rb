class OrdersController < ApplicationController    
    def index

    end

    def create
        userId = params[:userId]
        @user = User.find(userId)

        begin
            modify_user_balance(params)
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

    def modify_user_balance(params)        
        price = params[:usdInput].to_f        

        if (params[:type] == 'BUY')
            deduct_user_balance(price)
        else
            add_user_balance(price)
        end
        
    end

    def deduct_user_balance(price)
        if (@user.cash_balance < price)
            raise StandardError.new "You do not have sufficient cash balance"
        else            
            @user.cash_balance = @user.cash_balance - price
            @user.save
        end
    end

    def add_user_balance(price)
        @user.cash_balance = @user.cash_balance + price
        @user.save
    end
end