Rails.application.routes.draw do
  get '/accounts', to: "accounts#index"
  devise_for :users,  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get "/articles", to: "articles#index"

  root to: "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
