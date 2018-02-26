Rails.application.routes.draw do
  get 'suggestions/index', to: "suggestions#index", as: "suggestions"

  get 'users/:id/myrequests', to: "myrequests#index", as: "myrequests"

  get 'myrequests/show/:id', to: "myrequests#show", as: "myrequest"

  devise_for :users
  root to: 'pages#home'
  resources :requests, only: [:index, :new, :create]
  resources :rides, only: [:index, :show, :new, :create ]
  resources :user, only: [:show ]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
