# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::QuestionsController, type: :controller do
  let(:admin) { create(:admin) }

  describe "GET #new" do
    before { login(admin) }

    before { get :new }

    it "setups new question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    it "calls formula validator" do
      validator = class_double("FormulaValidator").as_stubbed_const

      allow(validator).to receive(:call).once

      post :create, params: { question: { formula_text: attributes_for(:text_formula)[:text] } }

      expect(validator).to have_received(:call).once
    end

    describe "with valid text formula, but without formula parameters" do
      it "calls formula parser" do
        parser = class_double("FormulaParser").as_stubbed_const

        allow(parser).to receive(:call).once

        post :create, params: { question: { formula_text: attributes_for(:text_formula)[:text] } }

        expect(parser).to have_received(:call).once
      end
    end

    describe "with invalid text formula" do
      it "redirects to new view" do
        post :create, params: { question: { formula_text: attributes_for(:text_formula, :invalid)[:text] } }

        expect(response).to redirect_to new_admin_question_path
      end
    end
  end
end
