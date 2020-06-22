Rails.application.routes.draw do

  get 'pages/index'

  root to: 'pages#index'

  get '/profil', to: 'users#edit', as: :profil
  get '/animaux/:slug', to: 'posts#species', as: :species_posts
  patch '/profil', to: 'users#update'

  # Session
  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :destroy_session

  resources :posts do
    collection do
      get 'me'
    end
  end
  resources :passwords, only: [:new, :create, :edit, :update]
  resources :pets do
    resource :subscriptions, only: [:create, :destroy]
  end
  resources :users, only: [:new, :create, :edit] do
    member do
      get 'confirm'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
