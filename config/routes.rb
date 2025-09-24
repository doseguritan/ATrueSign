Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, skip: [ :sessions, :registrations, :passwords, :confirmations, :unlocks ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :projects do
        collection do
          delete "", action: :destroy
        end
      end
      resources :users, only: [] do
        collection do
          get :organizations
          get :profile
        end
      end
    end
  end
end
