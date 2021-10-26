# frozen_string_literal: true

require 'sidekiq/web'

Rails
  .application
  .routes
  .draw do
    scope :api, defaults: { format: :html } do
      devise_for :users
    end
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(username),
        ::Digest::SHA256.hexdigest(
          Rails.application.credentials.sidekiq_username
        )
      ) &
        ActiveSupport::SecurityUtils.secure_compare(
          ::Digest::SHA256.hexdigest(password),
          ::Digest::SHA256.hexdigest(
            Rails.application.credentials.sidekiq_password
          )
        )
    end
    mount Sidekiq::Web, at: '/sidekiq'

    resources :coins
    resources :orders
    get 'orders/filter/:id', to: 'orders#filter'
    get 'portfolio', to: 'portfolios#index'
    get 'home/index'
    root to: 'home#index'
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
