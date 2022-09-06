Rails.application.routes.draw do
  resources :articles
  resources :users
  root 'pages#home'
end