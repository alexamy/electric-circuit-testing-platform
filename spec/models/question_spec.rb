# frozen_string_literal: true

require "rails_helper"

RSpec.describe Question, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :text }
    it { is_expected.to validate_presence_of :formula }
    it { is_expected.to validate_presence_of :precision }
    it { is_expected.to validate_presence_of :answer_unit }
    it { is_expected.to validate_presence_of :scheme }

    it { is_expected.to validate_numericality_of(:precision).only_integer.is_greater_than_or_equal_to(0) }
  end

  context "when uploads scheme" do
    let(:question) { build(:question) }

    it "allow upload" do
      question.scheme = create_file("spec/support/files/397KB.png")
      expect(question).to be_valid
    end

    it "allow only images" do
      question.scheme = create_file("spec/rails_helper.rb")
      expect(question).not_to be_valid
    end

    it "restrict files above 1 MB" do
      question.scheme = create_file("spec/support/files/1_4MB.png")
      expect(question).not_to be_valid
    end
  end

  it { is_expected.to belong_to :category }
  it { is_expected.to have_many(:formula_parameters).dependent(:destroy) }

  it "have one attached scheme" do
    expect(described_class.new.scheme).to be_an_instance_of ActiveStorage::Attached::One
  end

  it { is_expected.to accept_nested_attributes_for :formula_parameters }
end
