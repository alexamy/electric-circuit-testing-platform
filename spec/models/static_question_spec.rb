# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticQuestion, type: :model do
  let!(:question) { create(:question, formula: { dependencies: %w[R] }) }

  describe 'associations' do
    it { is_expected.to belong_to :question }
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :arguments }
    it { is_expected.to validate_presence_of :answer }

    it "isn't valid when have no corresponding question formula dependency" do
      expect(build(:static_question, arguments: { 'V' => 1 }, question: question)).not_to be_valid
    end
  end
end
