# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parameter, type: :model do
  describe 'validations' do
    let!(:question) { create(:question, formula_text: 'x=y', parameters: %w[y]) }

    it "isn't valid when have no corresponding question formula dependency" do
      expect(build(:parameter, name: 'I', question: question)).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to :question }
  end

  describe 'subtype checks' do
    it 'can determine step parameter' do
      expect(build(:step_parameter).step?).to eq true
    end

    it 'can determine enum parameter' do
      expect(build(:enum_parameter).enum?).to eq true
    end

    it 'can determine formula parameter' do
      expect(build(:formula_parameter).formula?).to eq true
    end
  end
end
