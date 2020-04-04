Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:index, :new, :create]
  match 'logout', to: 'sessions#destroy', via: [:get, :delete]
  get '/auth/:provider/callback', to: 'sessions#create'

  get 'shuffle', to: 'favorite_tweets#shuffle'
  get 'random', to: 'favorite_tweets#shuffle'

  resources :favorite_tweets do
    collection do
      get 'sync', to: 'favorite_tweets#sync'
    end
  end

  root to: "sessions#index"
end
