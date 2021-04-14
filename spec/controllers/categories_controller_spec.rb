# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    let(:categories) { create_list(:category, 3) }

    it 'load all categories' do
      get :index
      expect(assigns(:categories)).to match_array(categories)
    end

    it 'renders index view' do
      get :index
      expect(response).to render_template :index
    end
  end
end
