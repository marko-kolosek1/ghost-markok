Rails.application.routes.draw do
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
