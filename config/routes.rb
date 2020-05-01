Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'join', to: 'users#new'
  resources :users, only: [:index, :show, :create] do #後々 edit, update, destroy 追加予定
    member do
      get :sweets
    end 
  end  
      
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end 
  
  resources :likes, only: [:create, :destroy]
end
