Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :categories
  resources :sessions
  resources :products do
    post 'like', to: 'products#like'
  end
 
  resources :users 
  resources :ratings
  resources :conversations do
    resources :messages
  end
  get "stripe/connect", to: "stripe#connect", as: :stripe_connect
  scope '/checkout' do 
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'front#index'
  get    '/frontp',  to: 'front#index'
  get    '/signup',  to: 'users#new'
  post   '/signup', to:  'users#create'
  get '/search', to: 'welcome#search'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete 'logout', to: "sessions#destroy"
  get    '/welcome', to: "welcome#index"
  post   '/welcome', to: "welcome#index"
  
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
