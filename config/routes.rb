Rails.application.routes.draw do

  # get 'rides/:id/suggestions', to: "suggestions#index", as: "suggestions"
  root to: 'pages#home'

  resources :pages, only: :index

  get 'myrequests', to: "myrequests#index", as: "myrequests"

  get 'myrequests/:id', to: "myrequests#show", as: "myrequest"

  get 'users', to: "users#index"

  devise_for :users
  resources :requests, only: [:index, :new, :create]
  resources :rides, only: [:index, :show, :new, :create ] do
    resources :suggestions, only: :index
    resources :offers, only: [:create,:update]
  end
  resources :user, only: [:show ]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
