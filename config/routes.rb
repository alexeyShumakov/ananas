Rails.application.routes.draw do

  resources :pictures
  namespace :admin do
    resources :users
    resources :categories
    resources :comments
    resources :posts

    root to: "users#index"
  end

  get 'private_office', to: 'users#private_office'
  get 'users/search', to: 'users#search'
  resources :users, only: [:update]

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root 'categories#newest'

  get 'categories/newest', to: 'categories#newest'
  resources :categories, except: [:index]
  resources :posts, except: [:index] do
    get 'search', on: :collection
    get 'md_preview', on: :collection
  end
  resources :likes, only: [:create]
  resources :favorites, only: [:create]
  resources :comments
end
