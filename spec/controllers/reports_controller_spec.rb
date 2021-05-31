# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:student) { create(:student) }

  let!(:test) { create(:category, name: 'Test example', target_score: 6) }
  let!(:test_attempt) { create(:test_attempt, category: test, author: student) }
  let!(:answer) { create(:static_question, :correct, test_attempt: test_attempt, author: student) }

  before { login(student) }

  describe 'GET #student' do
    before { get :student }

    it 'sets tests' do
      expect(assigns(:tests)).to contain_exactly test
    end

    it 'sets attempts' do
      expect(assigns(:attempts)).to contain_exactly test_attempt
    end
  end
end
