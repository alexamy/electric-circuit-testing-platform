# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EnumParameter, type: :model do
  describe 'validations' do
    let!(:question) { create(:question, formula_text: 'x=y', parameters: %w[y]) }
    let(:parameter) { build(:enum_parameter, :invalid_variants, question: question) }

    it { is_expected.to validate_presence_of :variants }

    it 'isnt valid when has values other than numeric' do
      expect(parameter).not_to be_valid
    end

    it 'has array type variants attribute' do
      expect(parameter.variants).to be_instance_of Array
    end
  end

  describe '#generate_value' do
    before { srand(101) }

    describe 'integer intervals' do
      let(:variants) { [1, 2, 3, 4] }
      let(:parameter) { build(:enum_parameter, variants: variants) }
      let(:results) { Array.new(100) { parameter.generate_value } }

      it 'returns only values from variants' do
        expect(results.all? { |result| variants.include?(result) }).to eq true
      end
    end
  end
end
