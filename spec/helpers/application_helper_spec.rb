# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#seconds_to_minsec' do
    it 'shows seconds' do
      expect(seconds_to_minsec(1)).to eq '00:01'
    end

    it 'shows minutes' do
      expect(seconds_to_minsec(61)).to eq '01:01'
    end

    it 'dont count negative amount' do
      expect(seconds_to_minsec(-1)).to eq '00:00'
    end

    it 'overflows' do
      expect(seconds_to_minsec(6000)).to eq '100:00'
    end

    it 'round floats' do
      expect(seconds_to_minsec(3.5)).to eq '00:03'
    end
  end

  describe '#task_report_scheme_data' do
    let(:student) { create(:student) }
    let(:question) { create(:question) }
    let(:question_without_scheme) { create(:question, scheme: nil) }
    let(:attempt) { create(:attempt, author: student) }

    let(:task) { create(:task, question: question) }
    let(:task_without_scheme) { create(:task, question: question_without_scheme) }

    it 'returns nil for task without scheme' do
      report = Report::Task.new(task_without_scheme)
      expect(task_report_scheme_data(report)).to be_nil
    end

    it 'returns data attributes for task with scheme' do
      report = Report::Task.new(task)
      result = task_report_scheme_data(report)

      expect(result).to be_instance_of Hash
      expect(result).to have_key :tooltip_image
      expect(result).to have_key :hover_class
    end
  end
end
