# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  get '/tests', controller: 'categories', action: 'index_with_questions', as: 'tests'
  patch '/answer/:id', controller: 'static_questions', action: 'answer', as: 'answer'

  post '/test_attempt/:category_id', controller: 'tests', action: 'start', as: 'start_test_attempt'
  get '/test_attempt/:id', controller: 'tests', action: 'next_question', as: 'next_question_test_attempt'

  namespace :admin do
    resources :questions, shallow: true
  end
end
