# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  root to: 'pages#dashboard'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
