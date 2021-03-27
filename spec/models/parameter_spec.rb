# frozen_string_literal: true

require "rails_helper"

RSpec.describe Parameter, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :minimum }
    it { is_expected.to validate_presence_of :maximum }
    it { is_expected.to validate_presence_of :step }
    it { is_expected.to validate_presence_of :unit }
  end

  describe "associations" do
    it { is_expected.to belong_to :question }
  end
end
