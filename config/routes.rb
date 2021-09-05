Rails.application.routes.draw do
  root to: 'homes#index'
  devise_for :users
  resources :users do
    member do
      get 'followers'
      get 'followings'
    end
    resource :relationships, only: [:create, :destroy]
  end 
    resources :homes
  get "home/about" => 'homes#about'
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  
end
