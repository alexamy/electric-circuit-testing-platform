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

      post :create, params: { question: { formula_text: attributes_for(:text_formula)[:text] } }, format: :js

      expect(validator).to have_received(:call).once
    end

    it "renders create view" do
      post :create, params: { question: { formula_text: attributes_for(:text_formula)[:text] } }, format: :js
      expect(response).to render_template :create
    end

    describe "with valid text formula, but without formula parameters" do
      it "calls formula parser" do
        parser = class_double("FormulaParser").as_stubbed_const

        allow(parser).to receive(:call).once

        post :create, params: { question: { formula_text: attributes_for(:text_formula)[:text] } }, format: :js

        expect(parser).to have_received(:call).once
      end
    end

    describe "with invalid text formula" do
      before do
        post :create, params: { question: { formula_text: attributes_for(:text_formula, :invalid)[:text] } }, format: :js
      end

      it "sets error message to @alert" do
        expect(assigns(:alert)).to be_instance_of(String)
      end
    end
  end
end
