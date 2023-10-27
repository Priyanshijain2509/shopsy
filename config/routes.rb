Rails.application.routes.draw do
  devise_for :users
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  get '/products', to: 'products#index'
  get 'all_user', to: 'users#all_user', as: 'all_users'
  get '/order_list', to: 'users#order_list'
  get '/my_orders', to: 'users#my_order'
  get '/all_product', to: 'users#all_product'

  resources :users do
    resources :products do
      resources :orders, only: [:create, :update]
    end   
  end
  root 'static_pages#index'
end
