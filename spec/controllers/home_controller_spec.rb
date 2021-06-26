# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    let(:student) { create(:student) }

    it 'redirects to sign in when user is unregistered' do
      get :index

      expect(response).to redirect_to new_user_session_path
    end

    it 'redirects to tests path when user is registered' do
      login(student)
      get :index

      expect(response).to redirect_to tests_path
    end
  end
end
