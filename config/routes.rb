Rails.application.routes.draw do

  devise_for :users

  # admin
  namespace :admin do
    resources :posts
    resources :settings, only: ['index', 'update']
    resources :themes
    resources :users
    root :to => "welcome#index"
  end

  root :to => "posts#index"
  
end

