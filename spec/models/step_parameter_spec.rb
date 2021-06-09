# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/NestedGroups
RSpec.describe StepParameter, type: :model do
  describe 'validations' do
    let!(:question) { create(:question, formula_text: 'x=y', parameters: %w[y]) }

    it { is_expected.to validate_presence_of :minimum }
    it { is_expected.to validate_presence_of :maximum }
    it { is_expected.to validate_presence_of :step }

    it "isn't valid when minimum is greater than maximum" do
      expect(build(:parameter, :invalid_range, question: question)).not_to be_valid
    end
  end

  describe '#generate_value' do
    before { srand(101) }

    describe 'integer intervals' do
      let(:step) { 3 }
      let(:parameter) { build(:parameter, minimum: 10, maximum: 100, step: step) }
      let(:results) { Array.new(100) { parameter.generate_value } }

      it 'returns integer' do
        expect(results).to all be_an_instance_of Integer
      end

      it 'returns result greater or equal to minimum' do
        expect(results).to all be >= 10
      end

      it 'returns result less than or equal to maximum when maximum is in range' do
        expect(results).to all be <= 100
      end

      context 'with zero step' do
        let(:step) { 0 }

        it 'returns minimimum' do
          expect(results).to all eq 10
        end
      end

      context 'with negative step' do
        let(:step) { -10 }

        it 'returns minimimum' do
          expect(results).to all eq 10
        end
      end

      context 'with non-multiple step' do
        let(:step) { 80 }

        it 'returns less than maximum' do
          expect(results).to all be < 100
        end
      end
    end

    describe 'float intervals' do
      let(:step) { 0.1 }
      let(:parameter) { build(:parameter, minimum: 0.2, maximum: 0.4, step: step) }
      let(:results) { Array.new(100) { parameter.generate_value } }

      it 'returns big decimal' do
        expect(results).to all be_an_instance_of BigDecimal
      end

      it 'returns exact float values' do
        expect(results == results.map { |number| number.round(1) }).to be true
      end

      it 'returns result greater or equal to minimum' do
        expect(results).to all be >= 0.2
      end

      it 'returns result less than or equal to maximum when maximum is in range' do
        expect(results).to all be <= 0.4
      end

      context 'with non-multiple step' do
        let(:step) { 0.15 }

        it 'returns less than maximum' do
          expect(results).to all be < 0.4
        end
      end
    end
  end
end
# rubocop:enable RSpec/NestedGroups
