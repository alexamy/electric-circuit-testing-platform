# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
# rubocop:disable RSpec/LetSetup
RSpec.describe Report::Student, type: :service do
  let(:report) { described_class.new(student, test) }

  let(:student) { create(:student) }
  let(:student_other) { create(:student) }

  let(:test) { create(:test, name: 'Test example', target_score: 6) }
  let(:question) { create(:question, test: test) }

  let(:attempt) { create(:attempt, test: test, author: student) }
  let!(:answer) { create(:static_question, :correct, question: question, attempt: attempt, author: student) }
  let!(:answer_wrong) { create(:static_question, :wrong, question: question, attempt: attempt, author: student) }

  let!(:attempt_other) { create(:attempt, test: test, author: student_other) }
  let!(:answers_other) { create_list(:static_question, 5, :correct, question: question, attempt: attempt_other, author: student_other) }

  it 'sets user' do
    expect(report.user).to eq student
  end

  it 'sets test' do
    expect(report.test).to eq test
  end

  it 'sets test id' do
    expect(report.id).to eq test.id
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

  it 'sets answers count' do
    expect(report.answer_count).to eq 2
  end

  it 'sets attempts count' do
    expect(report.attempts).to contain_exactly attempt
  end

  it 'sets answers' do
    expect(report.answers).to contain_exactly answer, answer_wrong
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
# rubocop:enable RSpec/LetSetup
