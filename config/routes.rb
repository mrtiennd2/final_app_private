Rails.application.routes.draw do
  root 'photos#index'
  get '/home', to: 'photos#index'
  get '/photos', to: 'photos#index'

  # devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :users

  resources :users, only: %i[show index] do
    member do
      get '/', action: :photos
      post 'follow'
      post 'unfollow'
      get 'followers'
      get 'followings'
      get 'photos'
      get 'albums'
    end
  end

  authenticate :user, ->(u) { u.is_admin } do
    namespace :admin do
      resources :users
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
