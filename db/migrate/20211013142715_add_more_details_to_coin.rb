# frozen_string_literal: true

class AddMoreDetailsToCoin < ActiveRecord::Migration[6.1]
  def change
    add_column :coins, :description, :string
    add_column :coins, :block_time_in_minutes, :bigint
    add_column :coins, :sentiment_votes_up_percentage, :float
    add_column :coins, :sentiment_votes_down_percentage, :float
    add_column :coins, :price_change_percentage_7d, :float
    add_column :coins, :price_change_percentage_14d, :float
    add_column :coins, :price_change_percentage_30d, :float
    add_column :coins, :price_change_percentage_60d, :float
    add_column :coins, :price_change_percentage_200d, :float
    add_column :coins, :price_change_percentage_1y, :float
  end
end
