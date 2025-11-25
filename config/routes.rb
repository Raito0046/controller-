Rails.application.routes.draw do
  # OmniAuth callbacks
  get "/auth/:provider/callback", to: "sessions#omniauth"
  get "/auth/failure", to: "sessions#failure"

  resource :session
  resources :passwords, param: :token
  resources :movies
  resources :posters

  root "movies#index"
end