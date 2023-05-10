Rails.application.routes.draw do
  resources :carts
  resources :line_items
  resources :unit_types
  resources :categories
  resources :products
  resources :orders, only: [:new, :create]
  get '/carts:id', to: 'carts#show'
  get '/carts/current', to: 'carts#showcurrent'
  delete 'carts/:cart_id/line_items/:id', to: 'line_items#destroy', as: 'cart_line_item'
  post 'create_new_cart', to: 'carts#create_new_cart', as: 'create_new_cart'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
