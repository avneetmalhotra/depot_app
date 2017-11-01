Rails.application.routes.draw do
  resources :carts
  # get 'store/index'
  # ^this is replaces with below line
  # making store/index as root url of the website
  root 'store#index', as: 'store_index'

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
