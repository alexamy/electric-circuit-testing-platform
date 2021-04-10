# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParticularSolutionGenerator, type: :service do
  let(:question) { create(:question) }
  let(:generator) { described_class.new(question) }
  let(:result) { described_class.call(question) }

  describe '#new' do
    it 'saves question' do
      expect(generator.question).to eq question
    end

    it 'init arguments' do
      expect(generator.send(:arguments)).to be_instance_of Hash
    end

    it 'init calculator' do
      expect(generator.send(:calculator)).to be_instance_of Dentaku::Calculator
    end
  end

  describe '::call' do
    it 'assigns arguments' do
      expect(result[:arguments].keys).to match_array question.formula['dependencies']
    end

    it 'assigns answer' do
      expect(result[:answer]).to be_present
    end
  end
end
