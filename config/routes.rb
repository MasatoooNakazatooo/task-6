Rails.application.routes.draw do
  root to: 'homes#index'
  devise_for :users
  resources :users
  resources :homes
  get "home/about" => 'homes#about'
  resources :books

  
end
