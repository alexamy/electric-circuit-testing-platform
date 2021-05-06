# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Formula::Normalizer, type: :service do
  let(:normalizer) { described_class }

  it 'strips whitespace in start' do
    expect(normalizer.normalize("\n\nr=x")).to eq 'r=x'
  end

  it 'strips whitespace in middle' do
    expect(normalizer.normalize("r=x\n  \nz=r")).to eq "r=x\nz=r"
  end

  it 'split lines' do
    expect(normalizer.lines("  r=x\ny=z  ")).to eq ['r=x', 'y=z']
  end
end
