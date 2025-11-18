# config/routes.rb (add inside Rails.application.routes.draw do ... end)
get "/auth/:provider/callback", to: "sessions#omniauth"
get "/auth/failure", to: "sessions#failure"

Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :movies
  root "movies#index"
end


