# frozen_string_literal: true

require "rails_helper"

RSpec.describe FormulaValidator, type: :service do
  let(:validator) { described_class }
  let(:formula) { "Rx=R2*R3/(R2+R3) \n Vxmm1=VCC*Rx/(R1+Rx)" }

  it "saves provided text" do
    expect(validator.new("sample").text).to eq "sample"
  end

  it "split text by lines and save it" do
    expect(validator.new("sample1 \n sample2").entries).to eq %w[sample1 sample2]
  end

  it "validates correct formula" do
    expect(validator.call(formula)).to be true
  end

  it "checks assignments" do
    expect(validator.call("ab")).to be false
    expect(validator.call("ab \n a=b")).to be false
    expect(validator.call("=ab \n =ab")).to be false
    expect(validator.call("ab= \n ab=")).to be false

    expect(validator.call("a=1 \n b=2")).to be true
  end

  it "checks assignment target" do
    expect(validator.call("1x=2")).to be false
    expect(validator.call("x*=2")).to be false

    expect(validator.call("x=2")).to be true
    expect(validator.call("X=2")).to be true
    expect(validator.call("xy1=2")).to be true
    expect(validator.call("X1=2")).to be true
  end

  it "checks duplicate targets" do
    expect(validator.call("x=1 \n y=2 \n x=2")).to be false
  end
end
