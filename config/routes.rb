Rails.application.routes.draw do
  resources :articles
  resources :users
  get 'drafts', to: 'articles#drafts'
  get 'pending', to: 'articles#pending'
  get 'my_articles', to: 'articles#my_articles'
  resource :sessions, only: [:new, :create, :destroy]
  resources :tags
  root 'pages#home'
end
