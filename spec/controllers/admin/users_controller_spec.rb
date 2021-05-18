# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:admin) { create(:admin) }

  before { login(admin) }

  describe 'GET #index' do
    before { get :index }

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new'

  describe 'POST #create'

  describe 'GET #edit'

  describe 'PATCH #update'

  describe 'DELETE #destroy'
end
