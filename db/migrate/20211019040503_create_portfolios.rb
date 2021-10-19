class CreatePortfolios < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolios do |t|
      t.integer :user_id
      t.integer :coin_id
      t.float :total_quantity
      t.float :total_cost
      t.float :average_price      
            
      t.timestamps
    end
  end
end
