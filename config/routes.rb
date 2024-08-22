# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  root to: redirect('/dashboard')
  get '/dashboard', to: 'pages#dashboard'

  resources :notebooks do
    get :new_folder
    post :create_folder
    patch :delete
    delete :hard_delete
    resources :notes do
      patch :delete
      delete :hard_delete
    end
  end
end
