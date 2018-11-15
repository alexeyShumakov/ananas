Rails.application.routes.draw do

  resources :histories
  namespace :support do
    get :about
    get :partner
  end

  resources :pictures
  namespace :admin do
    resources :users
    resources :categories
    resources :comments
    resources :posts

    root to: "users#index"
  end

  get 'private_office', to: 'users#private_office'
  resources :users, only: [:update] do
    get 'search', on: :collection
    patch 'profile', on: :collection
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get 'users/:id/posts', to: 'posts#user_posts', as: :user_posts
  get 'posts/best_authors', to: 'posts#best_authors', as: :best_authors

  root 'categories#newest'

  get 'categories/newest', to: 'categories#newest'
  resources :categories
  resources :posts, except: [:index] do
    get 'search', on: :collection
    post 'md_preview', on: :collection
  end
  resources :likes, only: [:create]
  resources :favorites, only: [:create]
  resources :comments
end
