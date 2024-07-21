# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  root to: redirect('/dashboard')
  get '/dashboard', to: 'pages#dashboard'

  resources :notebooks
end
