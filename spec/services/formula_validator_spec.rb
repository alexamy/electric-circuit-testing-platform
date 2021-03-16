# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormulaValidator, type: :service do
  let(:validator) { described_class.new('sample') }

  it 'saves provided text' do
    expect(validator.text).to eq 'sample'
  end
end
