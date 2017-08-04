Rails.application.routes.draw do
  root 'products#index'
  get '/products' => 'products#index', as: :products
  get '/home' => 'products#index', as: :home

  devise_for :users
  resources :categories

  resource :cart, only: [:show]
  post 'cart/add' => 'carts#add_to_cart', as: :add_to_cart
  delete 'cart/remove/:cart_list_id' => 'carts#remove_from_cart', as: :remove_from_cart
  resources :products

  resources :users, except:[:new,:create] do
    resources :orders
  end
end
