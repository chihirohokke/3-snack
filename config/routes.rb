Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  get 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
  get 'join', to: 'users#new'
  resources :users, only: [:index, :show, :create]
end
