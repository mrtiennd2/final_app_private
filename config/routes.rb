Rails.application.routes.draw do
  root 'photos#index'

  devise_for :users

  get '/u/albums', to: 'albums#user_index'
  get '/u/photos', to: 'photos#user_index'

  resources :albums do
    resources :photos
  end

  # resources :photos

  get '/', to: 'photos#index'
  get '/home', to: 'photos#index'
  get '/photos', to: 'photos#index'


  # get '/u/albums', to: 'albums#user_index'
  # get '/u/photos', to: 'photos#user_index'
  #
  # resources :albums do
  #   resources :photos
  # end
  #
  # get '/', to: 'photos#index'
  # get '/home', to: 'photos#index'
  # get '/photos', to: 'photos#index'
end
