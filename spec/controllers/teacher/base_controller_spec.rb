# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher::BaseController, type: :controller do
  let(:user) { create(:user) }
  let(:teacher) { create(:teacher) }

  controller do
    def index
      head :ok
    end
  end

  it 'restrict access for unauthorized user' do
    allow(controller).to receive(:current_user).and_return(nil)
    get :index

    expect(response).to redirect_to root_path
  end

  it 'restrict access for student' do
    allow(controller).to receive(:current_user).and_return(user)
    get :index

    expect(response).to redirect_to root_path
  end

  it 'allow access for teacher' do
    allow(controller).to receive(:current_user).and_return(teacher)
    get :index

    expect(response).to be_successful
  end
end
