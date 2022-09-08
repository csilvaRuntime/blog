Rails.application.routes.draw do
  resources :articles
  resources :users
  get 'drafts', to: 'articles#drafts'
  get 'pending', to: 'articles#pending'
  resource :sessions, only: [:new, :create, :destroy]
  root 'pages#home'
end