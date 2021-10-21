class User < ApplicationRecord
  before_save :add_cash_balance
  has_many :orders, dependent: :destroy
  has_many :portfolios, dependent: :destroy  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  private

  def add_cash_balance
    self.cash_balance = 1000000.00
  end

end


