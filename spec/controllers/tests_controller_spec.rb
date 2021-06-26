# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe TestsController, type: :controller do
  let(:student) { create(:student) }
  let(:other_student) { create(:student) }

  let!(:tests) { create_list(:test, 5, name: 'test') }
  let(:test) { tests.first }

  let!(:attempt) { create(:attempt, test: test, author: student) }
  let(:other_attempt) { create(:attempt, test: test, author: other_student) }

  let!(:questions) { create_list(:question, 5, test: test) }
  let(:task) { create(:task, answer: 10, attempt: attempt, author: student) }
  let(:task_other) { create(:task, answer: 10, attempt: attempt, author: other_student) }

  describe 'GET #index' do
    let!(:test_name_first) { create(:test, name: 'a') }

    before { create(:question, test: test_name_first) }

    before do
      login(student)
      get :index
    end

    it 'load tests with questions ordered by name' do
      expect(assigns(:tests)).to eq [test_name_first, test]
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #start' do
    before { login(student) }

    it 'creates attempt' do
      expect do
        get :start, params: { test_id: test.id }
      end.to change(Attempt, :count).by 1
    end

    it 'redirects to show view' do
      get :start, params: { test_id: test.id }

      expect(response).to redirect_to next_question_attempt_path(assigns(:attempt))
    end

    it 'stops when get enough score' do
      10.times.each do
        create(:task, :correct, question: questions.first, attempt: attempt, author: student)
      end
      get :start, params: { test_id: test.id }

      expect(response).to redirect_to tests_path
    end
  end

  describe 'GET #next_question' do
    it_behaves_like 'require_authentication' do
      let(:action) { get :next_question, params: { id: test.id } }
    end

    describe 'Authenticated student' do
      before { login(student) }

      it 'sets current attempt' do
        get :next_question, params: { id: attempt.id }

        expect(assigns(:attempt)).to eq attempt
      end

      it 'sets current test' do
        get :next_question, params: { id: attempt.id }

        expect(assigns(:test)).to eq attempt.test
      end

      it 'sets current score' do
        get :next_question, params: { id: attempt.id }

        expect(assigns(:score)).to be_zero
      end

      it 'can proceed only on his attempt' do
        expect do
          get :next_question, params: { id: other_attempt.id }
        end.not_to change(Task, :count)
      end

      it 'can proceed on the latest attempt only' do
        Timecop.travel(5.minutes.from_now) do
          create(:attempt, test: test, author: student)
        end

        get :next_question, params: { id: attempt.id }

        expect(response).to have_http_status :forbidden
      end

      it 'dont create new attempts' do
        Timecop.travel(5.minutes.from_now) do
          create(:attempt, test: test, author: student)
        end

        expect do
          get :next_question, params: { id: attempt.id }
        end.not_to change(Task, :count)
      end

      it 'creates a new static question' do
        expect do
          get :next_question, params: { id: attempt.id }
        end.to change(Task, :count).by 1
      end

      it 'selects random question' do
        allow(controller).to receive(:random_question_id).and_return(questions[0].id)
        get :next_question, params: { id: attempt.id }

        expect(assigns(:question)).to eq questions[0]
      end

      it 'stops when get enough score' do
        10.times.each do
          create(:task, :correct, question: questions.first, attempt: attempt, author: student)
        end
        get :next_question, params: { id: attempt.id }

        expect(response).to redirect_to tests_path
      end

      it 'renders show view' do
        get :next_question, params: { id: attempt.id }

        expect(response).to render_template :next_question
      end
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
