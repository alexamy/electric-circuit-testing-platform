# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Formula::Parser, type: :service do
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

  before { parser.call }

  describe 'initialization' do
    it 'saves provided text' do
      expect(parser.text).to eq formula
    end

    it 'init calculator' do
      expect(parser.send(:calculator)).to be_instance_of Calculator
    end
  end

  describe 'parse' do
    it 'assigns last assigned variable as target' do
      expect(parser.target).to eq expected[:target]
    end

    it 'assigns dependencies' do
      expect(parser.dependencies).to contain_exactly(*expected[:dependencies])
    end

    it 'assigns solving hash' do
      expect(parser.bodies).to eq expected[:bodies]
    end
  end
end
