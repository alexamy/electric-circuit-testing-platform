# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:categories) { create_list(:category, 3) }
  let(:category) { categories.first }
  let(:user) { create(:user) }

  describe 'GET #index' do
    before { get :index }

    it 'load all categories' do
      expect(assigns(:categories)).to match_array(categories)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    describe 'Unauthenticated user' do
      before { get :show, params: { id: category.id } }

      it 'tries to start testing' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'Authenticated user' do
      before { login(user) }

      before { get :show, params: { id: category.id } }

      it 'sets current category' do
        expect(assigns(:category)).to eq category
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end
  end
end
