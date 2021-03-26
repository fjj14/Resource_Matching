Rails.application.routes.draw do
  resources :sessions
  resources :products
  resources :users
  resources :conversations do
    resources :messages
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#new'
  get    '/signup',  to: 'users#new'
  post   '/signup', to:  'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete 'logout', to: "sessions#destroy"
  get    '/welcome', to: "welcome#index"
  post   '/welcome', to: "welcome#index"
  
  get '/messages', to: 'conversations#index'
  post  '/messages', to: 'conversations#index'
 # get    '/createProduct', to: 'welcome#newProduct'
 # post   '/createProduct', to:  'welcome#newProduct'
  get    '/createProduct',  to: 'products#new'
  post   '/createProduct', to:  'products#create'

end
