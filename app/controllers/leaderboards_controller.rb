# frozen_string_literal: true

class LeaderboardsController < ApplicationController      
    def index
      @leaderboards = Leaderboard.all.order!('total_net_worth DESC')      
    end
  end
  