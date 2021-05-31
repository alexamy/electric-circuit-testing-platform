# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:student) { create(:student) }

  let!(:test) { create(:category, name: 'Test example', target_score: 6) }

  before { login(student) }

  describe 'GET #student' do
    before { get :student }

    it 'sets tests' do
      expect(assigns(:tests)).to contain_exactly test
    end
  end
end
