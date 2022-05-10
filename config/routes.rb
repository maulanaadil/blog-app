Rails.application.routes.draw do
  get '/accounts', to: "accounts#index"
  devise_for :users

  get '/sign_in', to: "sign_in#index"
  post '/sign_in', to: "sign_in#create"
  
  get '/sign_up', to: "sign_up#index"
  post '/sign_up', to: "sign_up#create"

  get "/articles", to: "articles#index"

  root to: "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
