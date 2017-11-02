Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  # get 'store/index'
  # ^this is replaced with below line
  # making store/index as root url of the website
  root 'store#index', as: 'store_index'

  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
