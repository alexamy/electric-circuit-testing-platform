# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormulaParameter, type: :model do
  let(:question) { create(:question) }

  describe 'validations' do
    let!(:question) { create(:question, formula: { dependencies: %w[R] }) }

    it { is_expected.to validate_presence_of :minimum }
    it { is_expected.to validate_presence_of :maximum }
    it { is_expected.to validate_presence_of :step }

    it "isn't valid when minimum is greater than maximum" do
      expect(build(:formula_parameter, :invalid_range)).not_to be_valid
    end

    it "isn't valid when have no corresponding question formula dependency" do
      expect(build(:formula_parameter, name: 'I', question: question)).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to :question }
  end

  describe '#generate_value' do
    before { srand(101) }

    it 'returns minimimum for zero step' do
      parameter = build(:formula_parameter, minimum: 10, maximum: 100, step: 0)

      100.times.each do
        expect(parameter.generate_value).to eq 10
      end
    end

    it 'returns minimimum for negative step' do
      parameter = build(:formula_parameter, minimum: 10, maximum: 100, step: -10)

      100.times.each do
        expect(parameter.generate_value).to eq 10
      end
    end

    it 'returns result greater or equal to minimum' do
      parameter = build(:formula_parameter, minimum: 10, maximum: 100, step: 3)

      100.times.each do
        expect(parameter.generate_value).to be >= 10
      end
    end

    it 'returns result less than maximum' do
      parameter = build(:formula_parameter, minimum: 10, maximum: 20, step: 4)

      100.times.each do
        expect(parameter.generate_value).to be < 20
      end
    end

    it 'returns result less than or equal to maximum when maximum is in range' do
      parameter = build(:formula_parameter, minimum: 10, maximum: 100, step: 3)

      100.times.each do
        expect(parameter.generate_value).to be <= 100
      end
    end
  end
end
