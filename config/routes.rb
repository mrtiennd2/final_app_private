Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'signup/success', to: 'users#create', as: 'user_create'

  get 'users/:id', to: 'users#show', as: 'user'
end
