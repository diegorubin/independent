Rails.application.routes.draw do

  devise_for :users

  # admin
  namespace :admin do
    resources :posts
    root :to => "welcome#index"
  end

  root :to => "welcome#index"
  
end

