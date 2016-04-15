Rails.application.routes.draw do
  resources :categories, only: [:show]
end
