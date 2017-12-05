Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  
  namespace :admin do
    resources :reports, :categories, only: [:index]
  end

  controller :sessions do
    get     'login' => :new
    post    'login' => :create
    delete  'logout' => :destroy
  end

  match 'my-orders', to: 'users#orders', via: [:get]
  match 'my-items', to: 'users#line_items', via: [:get]

  resources :users

  resources :products, path: 'books' do
    get 'who_bought', on: :member
  end

  get 'categories/nested_list' => 'categories#nested_list'

  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    resources :categories
    root 'store#index', as: 'store_index'
  end

end
