# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#index'

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'

  get '/signup', to: 'users#new'
  get 'all_user', to: 'users#index'

  get '/products', to: 'products#index'

  get '/order_list', to: 'orders#index'

  devise_for :users

  resources :users do
    resources :products do
      resources :orders, only: %i[create update]
    end
  end
end
