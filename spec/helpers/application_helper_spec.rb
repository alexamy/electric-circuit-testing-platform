# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:helper) { Class.new { extend ApplicationHelper } }

  describe '#seconds_to_minsec' do
    it 'shows seconds' do
      expect(helper.seconds_to_minsec(1)).to eq '00:01'
    end

    it 'shows minutes' do
      expect(helper.seconds_to_minsec(61)).to eq '01:01'
    end

    it 'dont count negative amount' do
      expect(helper.seconds_to_minsec(-1)).to eq '00:00'
    end

    it 'overflows' do
      expect(helper.seconds_to_minsec(6000)).to eq '100:00'
    end

    it 'round floats' do
      expect(helper.seconds_to_minsec(3.5)).to eq '00:03'
    end
  end
end
