# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :categories, only: %i[index]
  get '/tests', to: 'categories#index'

  namespace :admin do
    resources :questions, shallow: true
  end

  root 'home#index'
end
