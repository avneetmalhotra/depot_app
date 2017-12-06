Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get     'login' => :new
    post    'login' => :create
    delete  'logout' => :destroy
  end

  get 'users/orders' => 'users#orders'
  get 'users/line_items' => 'users#line_items'

  resources :users
  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'store#index', as: 'store_index'
  end

  # resources :users do
  #   get :orders, on: :collection
  # end

  # get  'users/orders' => 'users#orders'
end
