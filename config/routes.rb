Rails.application.routes.draw do
  root 'photos#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  authenticate :user, ->(u) { u.is_admin } do
    namespace :admin do
      get 'dashboard', to: 'dashboard#index'
      resources :user, only: %i[edit update], as: :user_account, path: 'user_account'
    end
  end

  get '/u/albums(/m/:mode)', to: 'albums#user_albums'
  get '/u/photos(/m/:mode)', to: 'photos#user_photos'

  resources :photos

  resources :albums do
    resources :photos
  end

  get '/home', to: 'photos#index'
  get '/photos', to: 'photos#index'
end
