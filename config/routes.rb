Rails.application.routes.draw do
  resources :users
  resources :sessions
  resources :friends
  get 'home/index'
  get '/test', to: 'test#index'

  root 'home#index'
end
