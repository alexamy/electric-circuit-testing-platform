# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:categories) { create_list(:category, 5) }
  let(:category) { categories.first }

  let!(:questions) { create_list(:question, 5, category: category) }
  let(:static_question) { create(:static_question, answer: 10, author: user) }
  let(:static_question_other) { create(:static_question, answer: 10, author: other_user) }

  describe 'GET #index' do
    before { get :index }

    it 'load categories with questions' do
      expect(assigns(:categories)).to contain_exactly category
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

      it 'sets current category' do
        get :show, params: { id: category.id }

        expect(assigns(:category)).to eq category
      end

      it 'sets current score' do
        get :show, params: { id: category.id }

        expect(assigns(:score)).to be_zero
      end

      it 'creates a new static question' do
        expect do
          get :show, params: { id: category.id }
        end.to change(StaticQuestion, :count).by 1
      end

      it 'selects random question' do
        allow(controller).to receive(:random_question_id).and_return(questions[0].id)
        get :show, params: { id: category.id }

        expect(assigns(:question)).to eq questions[0]
      end

      it 'renders show view' do
        get :show, params: { id: category.id }

        expect(response).to render_template :show
      end
    end
  end

  describe 'PATCH #answer' do
    before { login(user) }

    it 'sets requested test' do
      patch :answer, params: { test_id: category.id, id: static_question.id }

      expect(assigns(:category)).to eq category
    end

    it 'sets requested static question' do
      patch :answer, params: { test_id: category.id, id: static_question.id }

      expect(assigns(:static_question)).to eq static_question
    end

    it 'restrict user to answer only his own static question' do
      expect do
        patch :answer, params: { test_id: category.id, id: static_question_other.id, answer: 100.0 }
      end.not_to change(static_question_other, :user_answer)
    end

    it 'allow answer only once' do
      patch :answer, params: { test_id: category.id, id: static_question.id, answer: 100.0 }
      patch :answer, params: { test_id: category.id, id: static_question.id, answer: 1000.0 }

      static_question.reload
      expect(static_question.user_answer).to eq 100.0
    end

    it 'saves user answer' do
      patch :answer, params: { test_id: category.id, id: static_question.id, answer: 100.0 }

      static_question.reload
      expect(static_question.user_answer).to eq 100.0
    end

    it 'redirects to next question' do
      patch :answer, params: { test_id: category.id, id: static_question.id }

      expect(response).to redirect_to test_path(category)
    end

    it 'redirects to tests list when has exit parameter' do
      patch :answer, params: { test_id: category.id, id: static_question.id, send_and_quit: true }

      expect(response).to redirect_to tests_path
    end
  end
end
