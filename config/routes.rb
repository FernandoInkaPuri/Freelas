Rails.application.routes.draw do
  devise_for :professionals
  devise_for :users
  root to: 'home#index'
  
  resources :projects, only: %i[new create show] do 
    get 'search', on: :collection
    get '/:project_id/accepted', to:'projects#accepted', on: :collection
    get '/:project_id/rejected', to:'projects#rejected', on: :collection
    get '/:project_id/team', to:'projects#rejected', on: :collection 
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
