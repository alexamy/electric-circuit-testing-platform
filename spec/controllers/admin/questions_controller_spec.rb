# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::QuestionsController, type: :controller do
  let(:admin) { create(:admin) }

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
    it 'calls formula validator' do
      validator = class_double('FormulaValidator').as_stubbed_const

      allow(validator).to receive(:call).once

      post :create, params: { question: { formula_text: attributes_for(:text_formula)[:text] } }

      expect(validator).to have_received(:call).once
    end

    describe 'with invalid text formula' do
      it 'sets error message to @alert' do
        post :create, params: { question: { formula_text: attributes_for(:text_formula, :invalid)[:text] } }
        expect(flash[:alert]).to be_present
      end

      it "doesn't set with_parameters flag" do
        post :create, params: { question: { formula_text: attributes_for(:text_formula, :invalid)[:text] } }

        expect(assigns(:with_parameters)).to be_nil
      end
    end

    describe 'with valid text formula, but without formula parameters' do
      it 'calls formula parser' do
        parser = class_double('FormulaParser').as_stubbed_const

        allow(parser).to receive(:call).once.and_return(dependencies: [])

        post :create, params: { question: { formula_text: attributes_for(:text_formula)[:text] } }

        expect(parser).to have_received(:call).once
      end

      it 'create new question with provided params' do
        post :create, params: { question: { formula_text: attributes_for(:text_formula)[:text] } }

        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'create parameters' do
        post :create, params: { question: { formula_text: 'V=R1/R2' } }

        parameters = assigns(:question).formula_parameters

        expect(parameters.length).to eq 2
        expect(parameters.first.name).to eq 'R1'
        expect(parameters.second.name).to eq 'R2'
      end

      it 'sets with_parameters flag' do
        post :create, params: { question: { formula_text: attributes_for(:text_formula)[:text] } }

        expect(assigns(:with_parameters)).to be true
      end

      it 'renders new view' do
        post :create, params: { question: { formula_text: attributes_for(:text_formula)[:text] } }
        expect(response).to render_template :new
      end
    end

    describe 'with valid text formula, with formula parameters' do
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
            scheme: create_file('spec/support/files/397KB.png'),
            formula_parameters_attributes: {
              "0": {
                name: 'Vx',
                minimum: '10',
                maximum: '100',
                step: '10',
                unit: 'В'
              }
            }
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

      it 'redirects to show view' do
        post :create, params: question_params
        expect(response).to redirect_to admin_question_path(assigns(:question))
      end

      xit 'restrict question creation when has malformed formula' do
        question_params_malformed = question_params.merge(formula_text: 'V=Vx*Vy')

        expect do
          post :create, params: question_params_malformed
        end.not_to change(Question, :count)
      end
    end
  end

  describe 'GET #show' do
    let(:question) { create(:question) }

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
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'assigns all questions' do
      expect(assigns(:questions)).to match_array questions
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
