Rails.application.routes.draw do
  resources :line_items
  resources :carts
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :categories
  resources :sessions
  
  resources :relationships,       only: [:create, :destroy]
  resources :products do
    post 'like', to: 'products#like'
    
  end
  resources :stripe
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :mailers
  resources :ratings
  resources :conversations do
    resources :messages
  end

  #Notification
  resources :notifications do
    
  end

  scope '/stripe' do
    post 'create', to: 'stripe#create', as: 'stripe_create'
    get 'refresh', to: 'stripe#refresh', as: 'stripe_refresh'
    get 'returns', to: 'stripe#returns', as: 'stripe_returns'
    get "stripe/dashboard/:user_id", to: "stripe#dashboard", as: :stripe_dashboard
  #  post 'dashboard', to: 'stripe#stripe_dashboard', as: 'stripe_dashboard'
  end
  scope '/checkout' do 
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'front#index'
  post 'add_to_cart', to: 'products#add_to_cart', as: 'product_add_to_cart'
  get    '/frontp',  to: 'front#index'
  get    '/signup',  to: 'users#new'
  post   '/signup', to:  'users#create'
  get '/search', to: 'welcome#search'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete 'logout', to: "sessions#destroy"
  get    '/welcome', to: "welcome#index"
  post   '/welcome', to: "welcome#index"
  get    '/cart', to: "carts#show"
  post   '/cart', to: "carts#show"
  get '/messages', to: 'conversations#index'
  post  '/messages', to: 'conversations#index'
  get    '/mypage', to: 'users#mypage'
  post   '/mypage', to:  'users#mypage'
  get    '/createProduct',  to: 'products#new'
  post   '/createProduct', to:  'products#create'
  delete 'deleteProduct', to: "products#destroy"
  get '/ratings/_form', to: "ratings#new"
  post   '/ratings/_form', to:  'ratings#create'
  get 'user/:id', to: 'users#show'
end
