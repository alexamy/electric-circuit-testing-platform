# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :tests, only: %i[index show]

  namespace :admin do
    resources :questions, shallow: true
  end

  root 'home#index'
end
