# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get '/tests', controller: 'tests', action: 'index', as: 'tests'
  post '/test_attempt/:category_id', controller: 'tests', action: 'start', as: 'start_test_attempt'
  get '/test_attempt/:id', controller: 'tests', action: 'next_question', as: 'next_question_test_attempt'
  patch '/answer/:question_id', controller: 'tests', action: 'answer', as: 'answer'

  resources :tests, only: %i[index show] do
    resources :answers, only: %i[update], controller: 'tests', action: 'answer', as: 'answer'
  end

  namespace :admin do
    resources :questions, shallow: true
  end

  root 'home#index'
end
