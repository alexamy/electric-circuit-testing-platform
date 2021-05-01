# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Formula::Parameter, type: :service do
  let(:generator) { described_class }

  it 'has voltage parameter info' do
    expect(generator.new('v').call[:unit]).to eq 'В'
    expect(generator.new('u').call[:unit]).to eq 'В'
  end

  it 'has resistance parameter info' do
    expect(generator.new('R').call[:unit]).to eq 'Ом'
  end

  it 'has diameter parameter info' do
    expect(generator.new('Dосн').call[:unit]).to eq 'мм'
  end

  it 'has default fallback' do
    expect(generator.new('x').call).to be_an_instance_of Hash
  end
end
