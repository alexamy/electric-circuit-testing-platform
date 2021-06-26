# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher::GroupsController, type: :controller do
  let!(:group) { create(:group) }
  let(:teacher) { create(:teacher) }

  before { login(teacher) }

  describe 'GET #index' do
    before { get :index }

    it 'sets groups' do
      expect(assigns(:groups)).to contain_exactly group
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'sets a new group' do
      expect(assigns(:group)).to be_a_new Group
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'creates a new group' do
      expect do
        post :create, params: { group: attributes_for(:group) }
      end.to change(Group, :count).by(1)
    end

    it 'redirects to index view' do
      post :create, params: { group: attributes_for(:group) }

      expect(response).to redirect_to teacher_groups_path
    end

    it 'rerender new view on failure' do
      post :create, params: { group: attributes_for(:group, :invalid) }

      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: group.id } }

    it 'finds the group' do
      expect(assigns(:group)).to eq group
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    it 'finds a group' do
      patch :update, params: { id: group.id, group: attributes_for(:group) }

      expect(assigns(:group)).to eq group
    end

    it 'updates a group' do
      patch :update, params: { id: group.id, group: { name: 'groupnew' } }

      group.reload
      expect(group.name).to eq 'groupnew'
    end

    it 'redirects to index view' do
      patch :update, params: { id: group.id, group: attributes_for(:group) }

      expect(response).to redirect_to teacher_groups_path
    end

    it 'rerenders edit view on failure' do
      patch :update, params: { id: group.id, group: attributes_for(:group, :invalid) }

      expect(response).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a group' do
      expect do
        delete :destroy, params: { id: group.id }
      end.to change(Group, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: { id: group.id }

      expect(response).to redirect_to teacher_groups_path
    end
  end
end
