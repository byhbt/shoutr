Rails.application.routes.draw do
  get 'dashboards/show'

  constraints Clearance::Constraints::SignedIn.new do
    root to: "dashboards#show"
  end

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resources :shouts, only: [:create, :show]
  resources :users, only: [:create, :show] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end
  resource :session, only: [:create]

  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
end
