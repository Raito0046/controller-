Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :movies
  root "movies#index"
end
