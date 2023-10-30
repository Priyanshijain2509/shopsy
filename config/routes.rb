# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  get '/products', to: 'products#index'
  get 'all_user', to: 'users#index'
  get '/all_product', to: 'products#show'
  get '/order_list', to: 'orders#index'
  get '/my_orders', to: 'orders#show'

  resources :users do
    resources :products do
      resources :orders, only: [:create, :update]
    end
  end
  root 'static_pages#index'
end
