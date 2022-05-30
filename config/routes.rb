Rails.application.routes.draw do
  get '/accounts', to: "accounts#index"
  
  get '/accounts/:id', to: 'accounts#show',  as: 'user'
  delete '/accounts/:id', to: 'accounts#destroy'
  put '/accounts/:id', to: 'accounts#update'
  patch '/accounts/:id', to: 'accounts#update'

  get '/accounts/:id/edit', to: 'accounts#edit', as: 'user_edit_role'

  devise_for :users,  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :articles do
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
