Rails.application.routes.draw do

  root :to => "welcome#index"
  devise_for :users

  # admin
  namespace :admin do
    resources :posts
  end
  
end

