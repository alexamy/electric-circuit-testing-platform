# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    it 'redirects' do
      get :index
      expect(response).to redirect_to tests_url
    end
  end
end
