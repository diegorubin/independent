Rails.application.routes.draw do

  devise_for :users

  # admin
  namespace :admin do
    resources :pages
    resources :posts
    resources :settings, only: ['index', 'update']
    resources :themes, only: ['index', 'new', 'create', 'show', 'destroy']
    resources :users
    root :to => "welcome#index"
  end

  resources :posts, only: ['index', 'show']
  root :to => "welcome#index"
  
end

