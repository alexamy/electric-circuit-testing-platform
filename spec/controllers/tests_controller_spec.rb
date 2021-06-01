# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe TestsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let!(:tests) { create_list(:test, 5) }
  let(:test) { tests.first }

  let!(:test_attempt) { create(:test_attempt, test: test, author: user) }
  let(:other_test_attempt) { create(:test_attempt, test: test, author: other_user) }

  let!(:questions) { create_list(:question, 5, test: test) }
  let(:static_question) { create(:static_question, answer: 10, test_attempt: test_attempt, author: user) }
  let(:static_question_other) { create(:static_question, answer: 10, test_attempt: test_attempt, author: other_user) }

  describe 'GET #index_with_questions' do
    before { get :index }

    it 'load tests with questions' do
      expect(assigns(:tests)).to contain_exactly test
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #start' do
    before { login(user) }

    it 'creates test attempt' do
      expect do
        get :start, params: { test_id: test.id }
      end.to change(TestAttempt, :count).by 1
    end

    it 'redirects to show view' do
      get :start, params: { test_id: test.id }

      expect(response).to redirect_to next_question_attempt_path(assigns(:test_attempt))
    end

    it 'stops when get enough score' do
      10.times.each do
        create(:static_question, :correct, question: questions.first, test_attempt: test_attempt, author: user)
      end
      get :start, params: { test_id: test.id }

      expect(response).to redirect_to tests_path
    end
  end

  describe 'GET #next_question' do
    it_behaves_like 'require_authentication' do
      let(:action) { get :next_question, params: { id: test.id } }
    end

    describe 'Authenticated user' do
      before { login(user) }

      it 'sets current test attempt' do
        get :next_question, params: { id: test_attempt.id }

        expect(assigns(:test_attempt)).to eq test_attempt
      end

      it 'sets current test' do
        get :next_question, params: { id: test_attempt.id }

        expect(assigns(:test)).to eq test_attempt.test
      end

      it 'sets current score' do
        get :next_question, params: { id: test_attempt.id }

        expect(assigns(:score)).to be_zero
      end

      it 'can proceed only on his test attempt' do
        expect do
          get :next_question, params: { id: other_test_attempt.id }
        end.not_to change(StaticQuestion, :count)
      end

      it 'can proceed on the latest test attempt only' do
        Timecop.travel(5.minutes.from_now) do
          create(:test_attempt, test: test, author: user)
        end

        expect do
          get :next_question, params: { id: test_attempt.id }
        end.not_to change(StaticQuestion, :count)
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

      it 'stops when get enough score' do
        10.times.each do
          create(:static_question, :correct, question: questions.first, test_attempt: test_attempt, author: user)
        end
        get :next_question, params: { id: test_attempt.id }

        expect(response).to redirect_to tests_path
      end

      it 'renders show view' do
        get :next_question, params: { id: test_attempt.id }

        expect(response).to render_template :next_question
      end
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
