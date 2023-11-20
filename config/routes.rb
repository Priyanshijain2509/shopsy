# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#index'

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#home'
  get '/contact', to: 'static_pages#home'
  get '/help', to: 'static_pages#home'

  get '/all_users', to: 'static_pages#home'
  get '/users', to: 'users#index'

  get '/products', to: 'products#index'
  get '/all_products', to: 'static_pages#home'
  get '/products/:id', to: 'products#show'
  get '/all_products/:id/edit', to: 'static_pages#home'
  put '/products/:id', to: 'products#update'
  get '/users/:user_id/products/new', to: 'static_pages#home'
  post '/products/new', to: 'products#create'

  get 'users/:user_id/products/:product_id/orders', to: 'static_pages#home'
  post '/orders/new', to: 'orders#create'
  get '/users/:user_id/products/:product_id/orders/:id', to: 'static_pages#home'
  put '/orders/cancel', to: 'orders#update'
  get '/order_list', to: 'static_pages#home'
  get 'orders', to: 'orders#index'

  devise_for :users

  resources :users do
    resources :products do
      resources :orders, only: %i[create update]
    end
  end
end
