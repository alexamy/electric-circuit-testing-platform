# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormulaParser, type: :service do
  let(:formula) { "Rx=R2*R3/(R2+R3)\nVxmm1=VCC*Rx/(R1+Rx)" }
  let(:parser) { described_class.new(formula) }

  let(:expected) do
    {
      target: 'Vxmm1',
      dependencies: %w[R1 R2 R3 VCC],
      bodies: {
        Rx: 'R2*R3/(R2+R3)',
        Vxmm1: 'VCC*Rx/(R1+Rx)'
      }
    }
  end

  describe 'initialization' do
    before { parser.call }

    it 'saves provided text' do
      expect(parser.text).to eq formula
    end

    it 'init calculator' do
      expect(parser.send(:calculator)).to be_instance_of Dentaku::Calculator
    end
  end

  describe 'parse' do
    before { parser.call }

    it 'assigns last assigned variable as target' do
      expect(parser.target).to eq expected[:target]
    end

    it 'assigns dependencies' do
      expect(parser.dependencies).to contain_exactly(*expected[:dependencies])
    end

    it 'assigns solving hash' do
      expect(parser.bodies).to eq expected[:bodies]
    end

    describe 'ignores multiple spaces and newlines' do
      it 'skips whitespace in start' do
        result = described_class.call("\n\nr=x")

        expect(result[:bodies].keys.size).to eq 1
      end

      it 'skips whitespace in middle' do
        result = described_class.call("r=x\n\nz=r")

        expect(result[:bodies].keys.size).to eq 2
      end
    end
  end
end
