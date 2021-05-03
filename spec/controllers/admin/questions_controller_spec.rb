# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::QuestionsController, type: :controller do
  let(:admin) { create(:admin) }
  let!(:questions) { create_list(:question, 3) }
  let(:question) { questions.first }

  before { login(admin) }

  describe 'GET #new' do
    before { get :new }

    it 'setups new question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:category) { create(:category) }
    let(:question_params) do
      {
        question: {
          category_id: category.id,
          formula_text: 'V=Vx',
          text: 'Найдите V',
          precision: 0,
          answer_unit: 'В',
          completion_time: 2,
          scheme: create_file('spec/support/files/397KB.png')
        }
      }
    end

    it 'creates question' do
      expect do
        post :create, params: question_params
      end.to change(Question, :count).by(1)
    end

    it 'creates formula parameters' do
      expect do
        post :create, params: question_params
      end.to change(FormulaParameter, :count).by(1)
    end

    it 'calls formula validator' do
      validator = class_double('Formula::Validator').as_stubbed_const
      allow(validator).to receive(:call).once

      post :create, params: question_params

      expect(validator).to have_received(:call).once
    end

    it 'calls formula parser' do
      parser = class_double('Formula::Parser').as_stubbed_const
      allow(parser).to receive(:call).once.and_return(dependencies: [])

      post :create, params: question_params

      expect(parser).to have_received(:call).once
    end

    it 'redirects to update parameters view' do
      post :create, params: question_params
      expect(response).to redirect_to admin_question_edit_parameters_path(assigns(:question))
    end

    describe 'errors' do
      it 'sets error message to @alert for invalid text formula' do
        post :create, params: { question: { formula_text: attributes_for(:text_formula, :invalid)[:text] } }

        expect(flash[:alert]).to be_present
      end

      it 'renders new view for missing attributes' do
        post :create, params: { question: { formula_text: 'v=x' } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question.id } }

    it 'assigns requested question' do
      expect(assigns(:question)).to eq question
    end

    it 'generates new static question' do
      expect(assigns(:static_question)).to be_a_new StaticQuestion
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #index' do
    before { get :index }

    it 'assigns all questions' do
      expect(assigns(:questions)).to match_array questions
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the question' do
      expect do
        delete :destroy, params: { id: question.id }
      end.to change(Question, :count).by(-1)
    end

    it 'redirects to questions list' do
      delete :destroy, params: { id: question.id }

      expect(response).to redirect_to admin_questions_path
    end
  end

  describe 'GET #edit' do
    it 'setups question' do
      get :edit, params: { id: question.id }

      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      get :edit, params: { id: question.id }

      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update'
end
