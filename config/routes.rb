Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'join', to: 'users#new'
  delete 'destroy_user', to: 'users#destroy'
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do 
    member do
      get :sweets
    end 
  end  
      
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end 
  
  resources :likes, only: [:create, :destroy]
end
