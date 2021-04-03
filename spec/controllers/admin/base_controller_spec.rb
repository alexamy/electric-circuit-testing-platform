# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::BaseController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  controller do
    def index
      head :ok
    end
  end

  it "restrict access for unauthorized user" do
    allow(controller).to receive(:current_user).and_return(nil)
    get :index

    expect(response).to redirect_to root_path
  end

  it "restrict access for student" do
    allow(controller).to receive(:current_user).and_return(user)
    get :index

    expect(response).to redirect_to root_path
  end

  it "allow access for admin" do
    allow(controller).to receive(:current_user).and_return(admin)
    get :index

    expect(response).to be_successful
  end
end
