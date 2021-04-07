# frozen_string_literal: true

require "rails_helper"

RSpec.describe ParticularSolutionGenerator, type: :service do
  let(:question) { create(:question) }
  let(:generator) { described_class.new(question) }
  let(:result) { described_class.call(question) }

  describe "#new" do
    it "saves question" do
      expect(generator.question).to eq question
    end

    it "init arguments" do
      expect(generator.send(:arguments)).to be_instance_of Hash
    end

    it "init calculator" do
      expect(generator.send(:calculator)).to be_instance_of Dentaku::Calculator
    end
  end

  describe "::call" do
    it "assigns arguments" do
      expect(result[:arguments].keys).to match_array question.formula["dependencies"]
    end

    it "assigns answer" do
      expect(result[:answer]).to be_present
    end
  end

  describe "#generate_value" do
    before { srand(101) }

    it "returns minimimum for zero step" do
      100.times.each do
        expect(generator.send(:generate_value, 10, 100, 0)).to eq 10
      end
    end

    it "returns minimimum for negative step" do
      100.times.each do
        expect(generator.send(:generate_value, 10, 100, -10)).to eq 10
      end
    end

    it "returns result greater or equal to minimum" do
      100.times.each do
        expect(generator.send(:generate_value, 10, 100, 3)).to be >= 10
      end
    end

    it "returns result less than maximum" do
      100.times.each do
        expect(generator.send(:generate_value, 10, 20, 4)).to be < 20
      end
    end

    it "returns result less than or equal to maximum when maximum is in range" do
      100.times.each do
        expect(generator.send(:generate_value, 10, 100, 3)).to be <= 100
      end
    end
  end
end
