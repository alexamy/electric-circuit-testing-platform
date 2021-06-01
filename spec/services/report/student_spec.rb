# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report::Student, type: :service do
  let(:report) { described_class.new(student, test) }

  let(:student) { create(:student) }
  let(:test) { create(:category, name: 'Test example', target_score: 6) }
  let(:test_attempt) { create(:test_attempt, category: test, author: student) }
  let(:question) { create(:question, category: test) }
  let!(:answer) { create(:static_question, :correct, question: question, test_attempt: test_attempt, author: student) }
  let!(:answer_wrong) { create(:static_question, :wrong, question: question, test_attempt: test_attempt, author: student) }

  it 'sets user' do
    expect(report.user).to eq student
  end

  it 'sets test' do
    expect(report.test).to eq test
  end

  it 'sets name' do
    expect(report.name).to eq test.name
  end

  it 'sets target score' do
    expect(report.target_score).to eq test.target_score
  end

  it 'sets score' do
    expect(report.score).to eq(-1)
  end

  it 'sets percentage' do
    expect(report.correctness).to be 0.5
  end

  it 'sets attempts count' do
    expect(report.attempts).to contain_exactly test_attempt
  end

  it 'sets answers' do
    expect(report.answers).to contain_exactly answer, answer_wrong
  end
end
