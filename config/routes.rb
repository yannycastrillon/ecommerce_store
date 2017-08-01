Rails.application.routes.draw do
  root 'products#index'

  devise_for :users

  resource :cart, only: [:show]
  post 'cart/add' => 'carts#add_to_cart', as: :add_to_cart
  delete 'cart/remove/:cart_list_id' => 'carts#remove_from_cart', as: :remove_from_cart
  resources :products

  resources :users do
    resources :orders
  end
end
