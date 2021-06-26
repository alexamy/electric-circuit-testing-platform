# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher::TestsController, type: :controller do
  let(:teacher) { create(:teacher) }
  let!(:tests) { create_list(:test, 5) }
  let(:test) { tests.first }

  before { login(teacher) }

  describe 'GET #index' do
    it 'sets tests' do
      get :index

      expect(assigns(:tests)).to match_array tests
    end

    it 'renders index view' do
      get :index

      expect(response).to render_template :index
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes test' do
      expect do
        delete :destroy, params: { id: test.id }
      end.to change(Test, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { id: test.id }

      expect(response).to redirect_to teacher_tests_path
    end
  end

  describe 'GET #new' do
    it 'setup new test' do
      get :new

      expect(assigns(:test)).to be_a_new Test
    end

    it 'renders new view' do
      get :new

      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'create new test in database' do
      expect do
        post :create, params: { test: attributes_for(:test) }
      end.to change(Test, :count).by(1)
    end

    it 'redirects to index on success' do
      post :create, params: { test: attributes_for(:test) }

      expect(response).to redirect_to teacher_tests_path
    end

    it 'rerenders new on failure' do
      post :create, params: { test: attributes_for(:test, :invalid) }

      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'finds the test' do
      get :edit, params: { id: test.id }

      expect(assigns(:test)).to eq test
    end

    it 'renders edit view' do
      get :edit, params: { id: test.id }

      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    it 'finds the test' do
      patch :update, params: { id: test.id, test: attributes_for(:test) }

      expect(assigns(:test)).to eq test
    end

    it 'changes test fields' do
      patch :update, params: { id: test.id, test: { name: 'newtest' } }

      test.reload
      expect(test.name).to eq 'newtest'
    end

    it 'redirects to index on success' do
      patch :update, params: { id: test.id, test: attributes_for(:test) }

      expect(response).to redirect_to teacher_tests_path
    end

    it 'rerenders new on failure' do
      patch :update, params: { id: test.id, test: attributes_for(:test, :invalid) }

      expect(response).to render_template :edit
    end
  end
end
