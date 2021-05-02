# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::FormulaParametersController, type: :controller do
  let(:admin) { create(:admin) }
  let(:question) { create(:question, author: admin) }

  before { login(admin) }

  describe 'GET #edit_bulk' do
    it 'sets question' do
      get :edit_bulk, params: { question_id: question.id }

      expect(assigns(:question)).to eq question
    end

    it 'renders edit_bulk view' do
      get :edit_bulk, params: { question_id: question.id }

      expect(response).to render_template :edit_bulk
    end
  end

  describe 'POST #update_bulk'
end
