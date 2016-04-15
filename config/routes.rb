Rails.application.routes.draw do
  root 'categories#newest'
  get 'categories/newest', to: 'categories#newest'
  resources :categories, only: [:show]
end
