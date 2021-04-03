# frozen_string_literal: true

require "rails_helper"

RSpec.describe FormulaParameter, type: :model do
  let(:question) { create(:question) }

  describe "validations" do
    it { is_expected.to validate_presence_of :minimum }
    it { is_expected.to validate_presence_of :maximum }
    it { is_expected.to validate_presence_of :step }
    it { is_expected.to validate_presence_of :unit }

    it "isn't valid when minimum is greater than maximum" do
      expect(build(:formula_parameter, :invalid_range)).not_to be_valid
    end
  end

  describe "associations" do
    it { is_expected.to belong_to :question }
  end
end
