# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::FormulaParametersController, type: :controller do
  let(:admin) { create(:admin) }
  let(:question) do
    create(:question, author: admin,
                      formula_text: 'X=I',
                      formula: { target: 'X', dependencies: %w[I], bodies: { X: 'I' } })
  end

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

  describe 'PATCH #update_bulk' do
    let(:update_params) do
      {
        question_id: question.id
      }
    end

    it 'sets question' do
      patch :update_bulk, params: update_params

      expect(assigns(:question)).to eq question
    end

    it 'renders edit_bulk view' do
      patch :update_bulk, params: update_params

      expect(response).to render_template :edit_bulk
    end
  end
end
