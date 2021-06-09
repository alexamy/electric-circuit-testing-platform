# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParticularSolutionGenerator, type: :service do
  let(:generator) { described_class.new(question) }
  let(:result) { described_class.call(question) }

  let(:question) do
    create(:question, formula_text: 'x=y+z',
                      parameters: { 'y' => { minimum: 5, maximum: 5, step: 0 },
                                    'z' => { minimum: 8, maximum: 8, step: 0 } })
  end

  describe '#new' do
    it 'saves question' do
      expect(generator.question).to eq question
    end

    it 'inits arguments' do
      expect(generator.send(:arguments)).to be_instance_of Hash
    end

    it 'inits calculator' do
      expect(generator.send(:calculator)).to be_instance_of Calculator
    end
  end

  describe '::call' do
    it 'assigns arguments' do
      expect(result[:arguments]).to eq({ 'y' => 5, 'z' => 8 })
    end

    it 'assigns answer' do
      expect(result[:answer]).to eq 13
    end
  end

  context 'when question has parameters with formula type' do
    let(:question) do
      create(:question, formula_text: 'x=y+z',
                        parameters: { 'y' => { minimum: 5, maximum: 5, step: 0 },
                                      'z' => { factory: :formula, formula: 'y*2' } })
    end

    it 'assigns answer' do
      expect(result[:answer]).to eq 15
    end

    it 'assigns arguments' do
      expect(result[:arguments]).to eq({ 'y' => 5, 'z' => 10 })
    end
  end
end
