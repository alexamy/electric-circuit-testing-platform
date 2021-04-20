# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  get '/tests', controller: 'categories', action: 'index_with_questions', as: 'tests'

  post '/test_attempt/:category_id', controller: 'tests', action: 'start', as: 'start_test_attempt'
  get '/test_attempt/:id', controller: 'tests', action: 'next_question', as: 'next_question_test_attempt'
  patch '/answer/:question_id', controller: 'tests', action: 'answer', as: 'answer'

  namespace :admin do
    resources :questions, shallow: true
  end
end
