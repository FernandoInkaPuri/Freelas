Rails.application.routes.draw do
  devise_for :professionals
  devise_for :users
  root to: 'home#index'
end
