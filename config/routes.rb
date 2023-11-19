Rails.application.routes.draw do
  root 'photos#index'
  get '/home', to: 'photos#index'
  get '/photos', to: 'photos#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users, only: %i[show index]

  authenticate :user, ->(u) { u.is_admin } do
    namespace :admin do
      get 'dashboard', to: 'dashboard#index'
      resources :user, only: %i[edit update destroy], as: :user_account, path: 'user_account'
    end
  end

  get '/u/albums(/m/:mode)', to: 'albums#user_albums'
  get '/u/photos(/m/:mode)', to: 'photos#user_photos'

  resources :photos do
    post 'like', member: true
  end

  resources :albums do
    post 'like', member: true
    resources :photos
  end
end
