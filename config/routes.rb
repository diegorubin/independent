Rails.application.routes.draw do

  devise_for :users

  # admin
  namespace :admin do
    namespace :api do
      namespace :v1 do
        resources :markdown, only: [:create]
        resources :posts, only: [:index, :create, :update, :destroy]
        post '/spellchecker/check', to: 'spellchecker#check', as: 'spellchecker'
        post '/spellchecker/add', to: 'spellchecker#add', as: 'spellchecker_add_word'
      end
    end

    resources :api_keys
    resources :assets
    resources :commentators, only: [:index, :update]
    resources :comments, only: [:index, :update, :destroy]
    resources :filters, only: [:show]
    resources :galleries
    resources :images
    resources :pages
    resources :posts
    resources :partials, only: [:index]
    resources :presentations
    resources :settings, only: ['index', 'update']
    resources :snippets
    resources :themes, only: ['index', 'new', 'create', 'show', 'destroy']
    resources :users
    resources :widgets, only: ['index', 'new', 'create', 'show', 'update',  'destroy'] do
      resources :nesteds, only: ['new']
    end

    root :to => "welcome#index"
  end

  get "/category/:category" => "welcome#index", :as => "category"
  get "/tag/:tag" => "welcome#index", :as => "tag"
  get "/:date" => "welcome#index", 
        :as => "date", 
        :date => /\d{4}(\/\d{2}){0,2}/

  resources :pageviews, only: ['create']

  # Assets
  get "/assets/:slug" => "assets#show", :as => "asset"
  get "/images/:slug" => "images#show", :as => "image"

  # Comments
  resources :comments, only: [:create]

  # Pages
  get "/pages/:slug" => "pages#show", :as => "page"

  # Posts
  get "/posts" => "posts#index", :as => "posts"
  get "/posts/:page" => "posts#index"
  get "/posts/:date" => "posts#index", 
        :as => "post_date", 
        :date => /\d{4}(\/\d{2}){0,2}/
  get ":date/:slug" => "posts#show", 
        :as => "post", 
        :date => /\d{4}(\/\d{2}){2}/

   # Presentations
  get "/presentations" => "presentations#index", :as => "presentations"
  get "/presentations/:page" => "presentations#index"
  get "/presentations/:date" => "presentations#index", 
        :as => "presentation_date", 
        :date => /\d{4}(\/\d{2}){0,2}/
  get "/presentations/:date/:slug" => "presentations#show", 
        :as => "presentation", 
        :date => /\d{4}(\/\d{2}){2}/ 

  # feeds
  get "/feed" => "feeds#index", :as => "feeds"

  root :to => "welcome#index"
  
end

