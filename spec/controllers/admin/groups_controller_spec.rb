# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::GroupsController, type: :controller do
  let(:admin) { create(:admin) }

  before { login(admin) }

  describe 'GET #index'

  describe 'GET #new'

  describe 'POST #create'

  describe 'GET #edit'

  describe 'PATCH #update'

  describe 'DELETE #destroy'
end
