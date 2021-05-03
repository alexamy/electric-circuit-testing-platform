# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:admin) { create(:admin) }
  let!(:categories) { create_list(:category, 5) }
  let(:category) { categories.first }

  before { login(admin) }

  describe 'GET #index' do
    it 'sets categories' do
      get :index

      expect(assigns(:categories)).to match_array categories
    end

    it 'renders index view' do
      get :index

      expect(response).to render_template :index
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes category' do
      expect do
        delete :destroy, params: { id: category.id }
      end.to change(Category, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { id: category.id }

      expect(response).to redirect_to admin_categories_path
    end
  end

  describe 'GET #new' do
    it 'setup new category' do
      get :new

      expect(assigns(:category)).to be_a_new Category
    end

    it 'renders new view' do
      get :new

      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'create new category in database' do
      expect do
        post :create, params: { category: attributes_for(:category) }
      end.to change(Category, :count).by(1)
    end

    it 'redirects to index on success' do
      post :create, params: { category: attributes_for(:category) }

      expect(response).to redirect_to admin_categories_path
    end

    it 'rerenders new on failure' do
      post :create, params: { category: attributes_for(:category, :invalid) }

      expect(response).to render_template :new
    end
  end
end
