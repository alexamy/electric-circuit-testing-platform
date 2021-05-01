# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Formula::Normalizer, type: :service do
  let(:normalizer) { described_class }

  it 'strips whitespace in start' do
    expect(normalizer.new("\n\nr=x").text).to eq 'r=x'
  end

  it 'strips whitespace in middle' do
    expect(normalizer.new("r=x\n  \nz=r").text).to eq "r=x\nz=r"
  end
end
