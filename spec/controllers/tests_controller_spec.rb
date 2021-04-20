# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe TestsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:categories) { create_list(:category, 5) }
  let(:category) { categories.first }

  let!(:test_attempt) { create(:test_attempt, category: category, author: user) }
  let(:other_test_attempt) { create(:test_attempt, category: category, author: other_user) }

  let!(:questions) { create_list(:question, 5, category: category) }
  let(:static_question) { create(:static_question, answer: 10, test_attempt: test_attempt, author: user) }
  let(:static_question_other) { create(:static_question, answer: 10, test_attempt: test_attempt, author: other_user) }

  describe 'GET #start' do
    before { login(user) }

    it 'creates test attempt' do
      expect do
        get :start, params: { category_id: category.id }
      end.to change(TestAttempt, :count).by 1
    end

    it 'redirects to show view' do
      get :start, params: { category_id: category.id }

      expect(response).to redirect_to next_question_test_attempt_path(assigns(:test_attempt))
    end
  end

  describe 'GET #next_question' do
    describe 'Unauthenticated user' do
      before { get :next_question, params: { id: category.id } }

      it 'tries to start testing' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'Authenticated user' do
      before { login(user) }

      it 'sets current test attempt' do
        get :next_question, params: { id: test_attempt.id }

        expect(assigns(:test_attempt)).to eq test_attempt
      end

      it 'can proceed only on his test attemp' do
        expect do
          get :next_question, params: { id: other_test_attempt.id }
        end.not_to change(StaticQuestion, :count)
      end

      it 'can proceed on the latest test attempt only' do
        Timecop.travel(5.minutes.from_now) do
          create(:test_attempt, category: category, author: user)
        end

        expect do
          get :next_question, params: { id: test_attempt.id }
        end.not_to change(StaticQuestion, :count)
      end

      it 'sets current category' do
        get :next_question, params: { id: test_attempt.id }

        expect(assigns(:category)).to eq test_attempt.category
      end

      it 'sets current score' do
        get :next_question, params: { id: test_attempt.id }

        expect(assigns(:score)).to be_zero
      end

      it 'creates a new static question' do
        expect do
          get :next_question, params: { id: test_attempt.id }
        end.to change(StaticQuestion, :count).by 1
      end

      it 'selects random question' do
        allow(controller).to receive(:random_question_id).and_return(questions[0].id)
        get :next_question, params: { id: test_attempt.id }

        expect(assigns(:question)).to eq questions[0]
      end

      it 'renders show view' do
        get :next_question, params: { id: test_attempt.id }

        expect(response).to render_template :next_question
      end
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
