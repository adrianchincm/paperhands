# frozen_string_literal: true

class AddCashBalanceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cash_balance, :float
  end
end
