# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ParametersController, type: :controller do
  let(:admin) { create(:admin) }
  let!(:question) do
    create(:question, author: admin,
                      formula_text: 'X=I',
                      parameters: { 'I' => {} })
  end

  before { login(admin) }

  describe 'GET #edit' do
    it 'sets question' do
      get :edit, params: { question_id: question.id }

      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      get :edit, params: { question_id: question.id }

      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let(:update_params) do
      {
        question_id: question.id,
        question: {
          parameters_attributes: {
            '0' => {
              id: question.parameters.first.id,
              name: 'I',
              minimum: 5,
              maximum: 50,
              step: 5,
              unit: 'Ампер'
            }
          }
        }
      }
    end

    let(:update_params_invalid) do
      {
        question_id: question.id,
        question: {
          parameters_attributes: {
            '0' => {
              id: question.parameters.first.id,
              name: 'Iyy',
              minimum: 5,
              maximum: 50,
              step: 5,
              unit: 'Ампер'
            },
            '1' => {
              name: 'X',
              minimum: 5,
              maximum: 50,
              step: 5,
              unit: 'Ампер'
            }
          }
        }
      }
    end

    it 'sets question' do
      patch :update, params: update_params

      expect(assigns(:question)).to eq question
    end

    it 'changes parameter values' do
      patch :update, params: update_params

      parameter = question.parameters.first
      parameter.reload

      expect(parameter.minimum).to eq 5
      expect(parameter.maximum).to eq 50
      expect(parameter.step).to eq 5
      expect(parameter.unit).to eq 'Ампер'
    end

    it 'renders edit view with notice' do
      patch :update, params: update_params

      expect(flash[:notice]).to be_present
      expect(response).to render_template :edit
    end

    describe 'errors' do
      it 'dont create new parameters' do
        expect do
          patch :update, params: update_params_invalid
        end.not_to change(Parameter, :count)
      end

      it 'dont change parameter name' do
        expect do
          patch :update, params: update_params_invalid
        end.not_to change(question.parameters.first, :name)
      end

      it 'renders edit view' do
        patch :update, params: update_params_invalid

        expect(response).to render_template :edit
      end
    end
  end
end
