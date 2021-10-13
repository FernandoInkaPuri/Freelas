Rails.application.routes.draw do
  devise_for :professionals
  devise_for :users
  root to: 'home#index'
  resources :projects, only: %i[new create]
end
