Rails.application.routes.draw do

  resources :posts
  get 'pets/index'
  root to: 'users#new'

  get 'passwords/new'
  get '/profil', to: 'users#edit',  as: :profil
  patch '/profil', to: 'users#update'

  #Session

  get '/login',    to: 'sessions#new', as: :new_session
  post '/login',   to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :destroy_session

  resources :passwords, only: [:new, :create, :edit, :update]
  resources :pets
  resources :users, only: [:new, :create] do
    member do
      get 'confirm'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
