# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get '/tests', controller: 'tests', action: 'index', as: 'tests'
  patch '/answer/:id', controller: 'tasks', action: 'answer', as: 'answer'

  post '/attempt/:test_id', controller: 'tests', action: 'start', as: 'start_attempt'
  get '/attempt/:id', controller: 'tests', action: 'next_question', as: 'next_question_attempt'

  scope :reports, controller: 'reports', as: 'reports' do
    get 'student'
    get 'test/:test_id', action: 'test', as: 'test'
  end

  scope :admin, as: 'admin' do
    scope :reports, controller: 'reports', as: 'reports' do
      get 'student/:id', action: 'student', as: 'student'
      get 'student/:id/test/:test_id', action: 'test', as: 'test'
    end
  end

  namespace :admin do
    resources :tests, shallow: true, except: %i[show]
    resources :students, shallow: true, except: %i[show]
    resources :groups, shallow: true, except: %i[show]

    resources :questions do
      resources :parameters, only: [] do
        get :edit, on: :collection
        patch :update, on: :collection
      end
    end
  end
end
