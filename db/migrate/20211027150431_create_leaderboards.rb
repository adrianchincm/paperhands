class CreateLeaderboards < ActiveRecord::Migration[6.1]
  def change
    create_table :leaderboards do |t|
      t.integer :user_id, index: { unique: true }
      t.float :total_cash
      t.float :total_crypto
      t.float :total_profit_loss_percentage
      t.float :total_net_worth
      t.integer :orders

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
