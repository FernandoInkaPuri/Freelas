Rails.application.routes.draw do
  devise_for :professionals
  devise_for :users
  root to: 'home#index'
  
  resources :projects, only: %i[new create show] do 
    get 'search', on: :collection
    get 'my_proposals', on: :collection
    resources :proposals, shallow:true do
      post 'accept', on: :member
      post 'reject', on: :member
    end
  end
  
  resources :profile, only: %i[new create show ] do 
    #get 'my_profile', on: :member
  end

end
