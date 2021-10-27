class CreateLeaderboards < ActiveRecord::Migration[6.1]
  def change
    create_table :leaderboards do |t|
      t.integer :user_id      
      t.float :total_cash
      t.float :total_crypto
      t.float :total_profit_loss
      t.float :orders

      t.timestamps
    end
  end
end
