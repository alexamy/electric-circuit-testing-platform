# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let!(:admin) { create(:admin) }
  let!(:student) { create(:student) }

  let!(:test) { create(:test, name: 'Test example', target_score: 6) }
  let!(:attempt) { create(:attempt, test: test, author: student) }
  let!(:question) { create(:question, test: test) }
  let(:answer) { create(:task, :correct, question: question, attempt: attempt, author: student) }
  let(:answer_wrong) { create(:task, :wrong, question: question, attempt: attempt, author: student) }

  describe 'GET #student' do
    describe 'student' do
      before do
        login(student)
        get :student
      end

      it 'sets reports' do
        expect(assigns(:reports)).to all be_an_instance_of(Report::Student)
      end

      it 'sets current user' do
        expect(assigns(:user)).to eq student
      end

      it 'renders student template' do
        expect(response).to render_template :student
      end
    end

    it 'dont use params when requested by student' do
      login(student)
      get :student, params: { id: admin.id }

      expect(assigns(:user)).to eq student
    end

    describe 'admin' do
      before { login(admin) }

      it 'sets current user' do
        get :student

        expect(assigns(:user)).to eq admin
      end

      it 'sets other user when requested by admin' do
        get :student, params: { id: student.id }

        expect(assigns(:user)).to eq student
      end
    end
  end

  describe 'GET #test' do
    describe 'Student' do
      before do
        login(student)
        get :test, params: { test_id: test.id }
      end

      it 'sets current user' do
        expect(assigns(:user)).to eq student
      end

      it 'sets report' do
        expect(assigns(:reports)).to all be_an_instance_of Report::Task
      end

      it 'sets test' do
        expect(assigns(:test)).to eq test
      end

      it 'render test template' do
        expect(response).to render_template :test
      end
    end

    describe 'Admin'

    it 'returns no content when test isnt found' do
      login(student)
      get :test, params: { test_id: 0 }

      expect(response).to have_http_status :no_content
    end
  end
end
