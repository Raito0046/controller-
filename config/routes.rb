Rails.application.routes.draw do
  # OmniAuth callbacks
  get "/auth/:provider/callback", to: "sessions#omniauth"
  get "/auth/failure", to: "sessions#failure"

  resources :param: :token
  resources :movies do
    resources :reviews, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
  resources :posters

  root "movies#index"
end
