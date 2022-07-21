Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
   namespace :v1 do
      resources :users
    end
  end

  root 'users#index'

  devise_for :users
  resources :users do
    member do
      patch 'update_password'
    end
    resources :stories
  end

  resources :settings, only: [:index]
end
