Rails.application.routes.draw do
  root 'products#index'

  devise_for :users

  resources :products

  resources :users do
    resources :orders
  end
end
