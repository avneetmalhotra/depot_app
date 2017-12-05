Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  namespace :admin do
    resources :reports, only: [:index]
  end

  controller :sessions do
    get     'login' => :new
    post    'login' => :create
    delete  'logout' => :destroy
  end

  get 'users/orders' => 'users#orders'
  get 'users/line_items' => 'users#line_items'

  get 'categories/nested_list' => 'categories#nested_list'

  resources :users
  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    resources :categories
    root 'store#index', as: 'store_index'
  end
end
