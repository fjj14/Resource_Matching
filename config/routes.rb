Rails.application.routes.draw do
<<<<<<< HEAD
  
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#new'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
=======
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#new'
>>>>>>> 74637a3e1ed78fd0f38b7c5868225dda58cd0958
end
