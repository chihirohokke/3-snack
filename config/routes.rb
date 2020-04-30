Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'join', to: 'users#new'
  resources :users, only: [:index, :show, :create] #後々 update, destroy 追加予定
  
  resources :posts
end
