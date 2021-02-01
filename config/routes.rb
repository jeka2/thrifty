Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :comments, only: [:create]
  get '/comments/new/:parent_id', to: 'comments#new', as: :new_comment

  resources :users, only: [:show] do 
    resources :items, only: [:index]
  end

  scope '/admin' do 
    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'user_login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  root 'static#home'
end
