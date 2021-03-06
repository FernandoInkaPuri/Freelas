Rails.application.routes.draw do
  devise_for :professionals
  devise_for :users
  root to: 'home#index'

  resources :projects, only: %i[new create show] do
    get 'search', on: :collection
    post 'close_registration', on: :member
    post 'close_project', on: :member
    get 'team', on: :member
    get 'my_projects', on: :collection
    get 'my_proposals', on: :collection
    get 'feedbacks', on: :collection
    post 'user_favorite', on: :member
    resources :proposals, shallow: true do
      post 'accept', on: :member
      post 'reject', on: :member
    end
  end
  resources :feedbacks, only: %i[new create]
  resources :professional_feedbacks, only: %i[new create]
  resources :user_feedbacks, only: %i[new create]
  resources :profiles, only: %i[new create show edit update] do
    post 'set_favorite', on: :member
    post 'unfavorite', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :projects, only: %i[index show create]
    end
  end
end
