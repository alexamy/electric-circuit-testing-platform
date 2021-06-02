# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get '/tests', controller: 'tests', action: 'index', as: 'tests'
  patch '/answer/:id', controller: 'static_questions', action: 'answer', as: 'answer'

  post '/attempt/:test_id', controller: 'tests', action: 'start', as: 'start_attempt'
  get '/attempt/:id', controller: 'tests', action: 'next_question', as: 'next_question_attempt'

  scope :reports, controller: 'reports', as: 'reports' do
    get 'student'
  end

  namespace :admin do
    resources :tests, shallow: true, except: %i[show]
    resources :students, shallow: true, except: %i[show]
    resources :groups, shallow: true, except: %i[show]

    resources :questions, shallow: true do
      get '/update_parameters', controller: 'formula_parameters', action: 'edit_bulk', as: 'edit_parameters'
      patch '/update_parameters', controller: 'formula_parameters', action: 'update_bulk', as: 'update_parameters'
    end
  end

  scope :admin, as: 'admin' do
    scope :reports, controller: 'reports', as: 'reports' do
      get 'student/:id', action: 'student', as: 'student'
    end
  end
end
