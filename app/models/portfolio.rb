# frozen_string_literal: true

class Portfolio < ApplicationRecord
  belongs_to :user
  belongs_to :coin
end
