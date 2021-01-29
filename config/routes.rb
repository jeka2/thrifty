Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  resources :items, only: [:new, :create, :edit, :update, :delete, :show]

  scope '/admin' do 
    resources :categories, only: [:index, :new, :create, :edit, :update, :delete]
  end

  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'user_login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  root 'static#home'
end
