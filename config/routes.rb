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

  # Category
  get "/categories/:title" => "categories#show", :as => "category"

  # Pages
  get "/pages/:slug" => "pages#show", :as => "page"

  # Posts
  get "/posts" => "posts#index", :as => "posts"
  get "/posts/:page" => "posts#index"
  get ":date" => "posts#index", 
        :as => "post_date", 
        :date => /\d{4}(\/\d{2}){0,2}/
  get ":date/:slug" => "posts#show", 
        :as => "post", 
        :date => /\d{4}(\/\d{2}){2}/
  
  # temporario
  get '/welcome' => 'welcome#index', :as => 'welcome_path'
  root :to => "posts#index"
  
end

