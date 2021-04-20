# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticQuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:category) { create(:category) }
  let(:test_attempt) { create(:test_attempt, category: category, author: user) }
  let(:static_question) { create(:static_question, answer: 10, test_attempt: test_attempt, author: user) }
  let(:static_question_other) { create(:static_question, answer: 10, test_attempt: test_attempt, author: other_user) }

  describe 'PATCH #answer' do
    before { login(user) }

    it 'sets requested static question' do
      patch :answer, params: { id: static_question.id }

      expect(assigns(:static_question)).to eq static_question
    end

    it 'restrict user to answer only his own static question' do
      expect do
        patch :answer, params: { id: static_question_other.id, answer: 100.0 }
      end.not_to change(static_question_other, :user_answer)
    end

    it 'allow answer only once' do
      patch :answer, params: { id: static_question.id, answer: 100.0 }
      patch :answer, params: { id: static_question.id, answer: 1000.0 }

      static_question.reload
      expect(static_question.user_answer).to eq 100.0
    end

    it 'saves user answer' do
      patch :answer, params: { id: static_question.id, answer: 100.0 }

      static_question.reload
      expect(static_question.user_answer).to eq 100.0
    end

    it 'redirects to next question' do
      patch :answer, params: { id: static_question.id }

      expect(response).to redirect_to next_question_test_attempt_path(test_attempt)
    end

    it 'redirects to tests list when has exit parameter' do
      patch :answer, params: { id: static_question.id, send_and_quit: true }

      expect(response).to redirect_to tests_path
    end
  end
end
