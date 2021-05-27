# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:admin) { create(:admin) }
  let!(:student) { create(:student) }
  let(:users) { [admin, student] }

  before { login(admin) }

  describe 'GET #index' do
    before { get :index }

    it 'sets users' do
      expect(assigns(:users)).to match_array users
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'sets a new student' do
      expect(assigns(:user)).to be_a_new Student
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create'

  describe 'GET #edit' do
    before { get :edit, params: { id: student.id } }

    it 'finds the student' do
      expect(assigns(:user)).to eq student
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update'

  describe 'DELETE #destroy' do
    it 'deletes a user' do
      expect do
        delete :destroy, params: { id: student.id }
      end.to change(User, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { id: student.id }

      expect(response).to redirect_to admin_users_path
    end
  end
end
