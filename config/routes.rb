Rails.application.routes.draw do

  get 'private_office', to: 'users#private_office'
  devise_for :users

  root 'categories#newest'

  get 'categories/newest', to: 'categories#newest'
  resources :categories, only: [:show]
  resources :posts, except: [:index]
  resources :comments
end
