Rails.application.routes.draw do

  devise_for :users

  # admin
  namespace :admin do
    resources :pages
    resources :posts
    resources :presentations
    resources :settings, only: ['index', 'update']
    resources :snippets
    resources :themes, only: ['index', 'new', 'create', 'show', 'destroy']
    resources :users
    root :to => "welcome#index"
  end

  get "/category/:category" => "welcome#index", :as => "category"
  get "/tag/:tag" => "welcome#index", :as => "tag"

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

   # Presentations
  get "/presentations" => "presentations#index", :as => "presentations"
  get "/presentations/:page" => "presentations#index"
  get ":date" => "presentations#index", 
        :as => "presentation_date", 
        :date => /\d{4}(\/\d{2}){0,2}/
  get ":date/:slug" => "presentations#show", 
        :as => "presentation", 
        :date => /\d{4}(\/\d{2}){2}/ 

  root :to => "welcome#index"
  
end

