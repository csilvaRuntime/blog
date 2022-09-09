Rails.application.routes.draw do
  resources :articles
  resources :users
  resource :sessions, only: [:new, :create, :destroy]
  resources :tags
  root 'pages#home'
end
