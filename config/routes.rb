Rails.application.routes.draw do
  # get 'rides/:id/suggestions', to: "suggestions#index", as: "suggestions"

  get 'users/:id/myrequests', to: "myrequests#index", as: "myrequests"

  get 'users/:user_id/myrequests/:id', to: "myrequests#show", as: "myrequest"

  devise_for :users
  root to: 'pages#home'
  resources :requests, only: [:index, :new, :create]
  resources :rides, only: [:index, :show, :new, :create ] do
    resources :suggestions, only: :index
  end
  resources :user, only: [:show ]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
