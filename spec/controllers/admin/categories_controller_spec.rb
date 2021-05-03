# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:admin) { create(:admin) }
  let(:categories) { create_list(:category, 5) }

  before { login(admin) }

  describe 'GET #index' do
    it 'sets categories' do
      get :index

      expect(assigns(:categories)).to match_array categories
    end

    it 'renders index view' do
      get :index

      expect(response).to render_template :index
    end
  end
end
