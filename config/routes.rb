Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions
  get '/auth/:provider/callback', to: 'sessions#create'

  get 'favorites/sync', to: 'favorite_tweets#sync'

  root to: "sessions#index"
end
