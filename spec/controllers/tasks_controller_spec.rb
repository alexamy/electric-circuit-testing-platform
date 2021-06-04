# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:test) { create(:test) }
  let(:attempt) { create(:attempt, test: test, author: user) }
  let(:question) { create(:question) }
  let!(:task) { create(:task, answer: 10, attempt: attempt, question: question, author: user) }
  let!(:task_other) { create(:task, answer: 10, attempt: attempt, question: question, author: other_user) }

  describe 'PATCH #answer' do
    it_behaves_like 'require_authentication' do
      let(:action) { patch :answer, params: { id: task.id } }
    end

    describe 'Authenticated user' do
      before { login(user) }

      it 'sets requested static question' do
        patch :answer, params: { id: task.id }

        expect(assigns(:task)).to eq task
      end

      it 'restrict user to answer only his own static question' do
        expect do
          patch :answer, params: { id: task_other.id, answer: 100.0 }
          task_other.reload
        end.not_to change(task_other, :user_answer)
      end

      it 'restrict user to answer only in completion time' do
        Timecop.travel(Time.current + question.completion_time + 1) do
          expect do
            patch :answer, params: { id: task.id, answer: 100.0 }
            task.reload
          end.not_to change(task, :user_answer)
        end
      end

      it 'allow answer only once' do
        patch :answer, params: { id: task.id, answer: 100.0 }
        patch :answer, params: { id: task.id, answer: 1000.0 }

        task.reload
        expect(task.user_answer).to eq 100.0
      end

      it 'saves user answer' do
        patch :answer, params: { id: task.id, answer: 100.0 }

        task.reload
        expect(task.user_answer).to eq 100.0
      end

      it 'redirects to next question' do
        patch :answer, params: { id: task.id }

        expect(response).to redirect_to next_question_attempt_path(attempt)
      end

      it 'redirects to tests list when has exit parameter' do
        patch :answer, params: { id: task.id, send_and_quit: true }

        expect(response).to redirect_to tests_path
      end
    end
  end
end
