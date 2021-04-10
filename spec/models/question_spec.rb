# frozen_string_literal: true

require "rails_helper"

RSpec.describe Question, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :text }
    it { is_expected.to validate_presence_of :formula }
    it { is_expected.to validate_presence_of :precision }
    it { is_expected.to validate_presence_of :answer_unit }

    it { is_expected.to validate_numericality_of(:precision).only_integer.is_greater_than_or_equal_to(0) }
  end

  it "allow to upload only images"

  it { is_expected.to belong_to :category }
  it { is_expected.to have_many(:formula_parameters).dependent(:destroy) }

  it "have one attached scheme" do
    expect(described_class.new.scheme).to be_an_instance_of ActiveStorage::Attached::One
  end

  it { is_expected.to accept_nested_attributes_for :formula_parameters }
end
