Rails.application.routes.draw do
  devise_for :users
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  get '/products', to: 'products#index'
  post '/new_user_product', to: 'products#new'

  resources :users do
    resources :products
  end

  root 'static_pages#index'
end
