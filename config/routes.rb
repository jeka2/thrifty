Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :items, only: [:index, :show]
  resources :comments, only: [:create]
  get '/comments/new/:parent_id', to: 'comments#new', as: :new_comment

  resources :users, only: [:show] do 
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    get '/cart', to: 'cart#show', as: 'show_cart'
    post '/purchase', to: 'purchases#create', as: 'make_purchase'
  end

  resources :categories, only: [:show]
  resources :departments, only: [:index, :show]

  scope '/admin' do 
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :departments, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :query_items, only: [:create]

  get 'categories/search', to: 'categories_search#new', as: 'search_categories'
  post 'categories/search', to: 'categories_search#create', as: 'query_categories'


  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'user_login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  post '/add_to_cart', to: 'cart_items#create', as: 'add_to_cart'
  post '/remove_from_cart', to: 'cart_items#delete', as: 'remove_from_cart'

  match '/auth/:google_oauth2/callback', to: 'sessions#google', via: [:get, :post]

  get '/confirmation', to: 'static#confirmation', as: 'confirmation_page'

  root 'static#home'
end
