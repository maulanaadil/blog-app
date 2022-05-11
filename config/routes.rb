Rails.application.routes.draw do
  get '/accounts', to: "accounts#index"
  devise_for :users,  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :articles, only: [:show, :create, :destroy, :index] do
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end
  
  root to: "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
