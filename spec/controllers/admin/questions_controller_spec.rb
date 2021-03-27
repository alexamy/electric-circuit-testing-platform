# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::QuestionsController, type: :controller do
  let(:admin) { create(:admin) }

  describe "GET #new" do
    before { login(admin) }

    before { get :new }

    it "render new view" do
      expect(response).to render_template :new
    end
  end
end
