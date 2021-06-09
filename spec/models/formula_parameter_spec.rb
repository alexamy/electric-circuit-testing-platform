# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormulaParameter, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :formula }

    it 'isnt valid when cant be computed'
  end

  describe '#generate_value' do
    let(:parameter) { build(:formula_parameter, formula: 'y*2') }

    it 'returns formula text' do
      expect(parameter.generate_value).to eq 'y*2'
    end
  end
end
