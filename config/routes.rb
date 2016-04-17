Rails.application.routes.draw do
  devise_for :users
  root 'categories#newest'
  get 'categories/newest', to: 'categories#newest'
  resources :categories, only: [:show]
end
