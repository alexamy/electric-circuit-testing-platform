# frozen_string_literal: true

require "rails_helper"

RSpec.describe StaticQuestion, type: :model do
  let(:category) { create(:category) }

  describe "validations" do
    it { is_expected.to validate_presence_of :arguments }
    it { is_expected.to validate_presence_of :answer }
  end
end
