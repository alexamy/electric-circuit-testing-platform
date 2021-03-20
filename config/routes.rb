# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :questions
  end

  root "home#index"
end
