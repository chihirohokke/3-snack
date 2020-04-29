Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'join', to: 'users#new'
  resources :users, only: [:index, :show, :create]
end
