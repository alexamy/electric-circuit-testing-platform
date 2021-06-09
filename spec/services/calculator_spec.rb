# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Calculator, type: :service do
  let(:calculator) { described_class.new }

  it 'inherits from dentaku calculator' do
    expect(described_class).to be < Dentaku::Calculator
  end

  describe 'clamp function' do
    it 'returns minimum if target is smaller' do
      expect(calculator.evaluate('clamp(1, 2, 4)')).to eq 2
    end

    it 'returns maximum if target is larger' do
      expect(calculator.evaluate('clamp(5, 2, 4)')).to eq 4
    end

    it 'returns target if target is in range' do
      expect(calculator.evaluate('clamp(3, 2, 4)')).to eq 3
    end
  end
end
