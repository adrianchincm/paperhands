# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.integer :coin_id, null: false
      t.float :price, null: false
      t.decimal :quantity, null: false
      t.string :order_type, null: false

      t.timestamps
    end
  end
end
