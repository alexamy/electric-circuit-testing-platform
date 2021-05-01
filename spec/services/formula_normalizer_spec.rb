# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormulaNormalizer, type: :service do
  let(:normalizer) { described_class }

  it 'strips whitespace in start' do
    expect(normalizer.call("\n\nr=x")).to eq 'r=x'
  end

  it 'strips whitespace in middle' do
    expect(normalizer.call("r=x\n  \nz=r")).to eq "r=x\nz=r"
  end
end
