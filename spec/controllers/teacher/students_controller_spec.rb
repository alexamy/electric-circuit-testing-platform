# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher::StudentsController, type: :controller do
  let(:group) { create(:group) }
  let(:teacher) { create(:teacher) }
  let!(:student) { create(:student) }

  before { login(teacher) }

  describe 'GET #index' do
    before { get :index }

    it 'sets users' do
      expect(assigns(:students)).to contain_exactly student
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'sets a new student' do
      expect(assigns(:student)).to be_a_new Student
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'creates a new user' do
      expect do
        post :create, params: { student: attributes_for(:student, group_id: group.id) }
      end.to change(User, :count).by(1)
    end

    it 'redirects to index view' do
      post :create, params: { student: attributes_for(:student, group_id: group.id) }

      expect(response).to redirect_to teacher_students_path
    end

    it 'rerender new view on failure' do
      post :create, params: { student: attributes_for(:student, first_name: '') }

      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: student.id } }

    it 'finds the student' do
      expect(assigns(:student)).to eq student
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    it 'finds a user' do
      patch :update, params: { id: student.id, student: attributes_for(:student) }

      expect(assigns(:student)).to eq student
    end

    it 'updates a user' do
      patch :update, params: { id: student.id, student: { first_name: 'first_name_new' } }

      student.reload
      expect(student.first_name).to eq 'first_name_new'
    end

    it 'exclude password key if it is empty' do
      patch :update, params: { id: student.id, student: { first_name: 'test', password: '' } }

      expect(controller.params[:student][:password]).to be_nil
    end

    it 'redirects to index view' do
      patch :update, params: { id: student.id, student: attributes_for(:student) }

      expect(response).to redirect_to teacher_students_path
    end

    it 'rerenders edit view on failure' do
      patch :update, params: { id: student.id, student: attributes_for(:student, first_name: '') }

      expect(response).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a user' do
      expect do
        delete :destroy, params: { id: student.id }
      end.to change(User, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { id: student.id }

      expect(response).to redirect_to teacher_students_path
    end
  end
end
