# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let!(:admin) { create(:admin) }
  let!(:student) { create(:student) }

  let!(:test) { create(:category, name: 'Test example', target_score: 6) }
  let!(:test_attempt) { create(:test_attempt, category: test, author: student) }
  let!(:question) { create(:question, category: test) }
  let(:answer) { create(:static_question, :correct, question: question, test_attempt: test_attempt, author: student) }
  let(:answer_wrong) { create(:static_question, :wrong, question: question, test_attempt: test_attempt, author: student) }

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
end
