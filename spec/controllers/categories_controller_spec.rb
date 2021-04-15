# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:categories) { create_list(:category, 5) }
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
    let(:admin) { create(:admin) }
    let!(:questions) { create_list(:question, 5, category: category, author: admin) }
    let(:question) { questions.first }

    describe 'Unauthenticated user' do
      before { get :show, params: { id: category.id } }

      it 'tries to start testing' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'Authenticated user' do
      before { login(user) }

      it 'sets current category' do
        get :show, params: { id: category.id }

        expect(assigns(:category)).to eq category
      end

      it 'creates a new static question' do
        expect do
          get :show, params: { id: category.id }
        end.to change(StaticQuestion, :count).by 1
      end

      it 'selects random question' do
        allow(controller).to receive(:random_question_id).and_return(question.id)
        get :show, params: { id: category.id }

        expect(assigns(:question)).to eq question
      end

      it 'renders show view' do
        get :show, params: { id: category.id }

        expect(response).to render_template :show
      end
    end
  end
end
