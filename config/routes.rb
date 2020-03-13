Rails.application.routes.draw do
  get 'dashboards/show'

  constraints Clearance::Constraints::SignedIn.new do
    root 'dashboards#show', as: :authenticated_root
  end

  root 'homes#show'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resources :shouts, only: [:create, :show] do
    member do
      post "like" => "likes#create"
      delete "unlike" => "likes#destroy"
    end
  end

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
