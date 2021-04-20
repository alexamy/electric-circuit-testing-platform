# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { create(:category) }
  let!(:question) { create(:question, category: category) }

  describe 'GET #index_with_questions' do
    before { get :index_with_questions }

    it 'load categories with questions' do
      expect(assigns(:categories)).to contain_exactly category
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
