# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
# rubocop:disable RSpec/LetSetup
RSpec.describe Report::Task, type: :service do
  let(:report) { described_class.new(answer) }

  let(:student) { create(:student) }
  let(:student_other) { create(:student) }

  let(:test) { create(:test, name: 'Test example', target_score: 6) }
  let(:question) { create(:question, test: test) }

  let(:attempt) { create(:attempt, test: test, author: student) }
  let!(:answer) { create(:static_question, :correct, question: question, attempt: attempt, author: student) }
  let!(:answer_wrong) { create(:static_question, :wrong, question: question, attempt: attempt, author: student) }

  let!(:attempt_other) { create(:attempt, test: test, author: student_other) }
  let!(:answers_other) { create_list(:static_question, 5, :correct, question: question, attempt: attempt_other, author: student_other) }

  it 'sets task' do
    expect(report.task).to eq answer
  end

  it 'sets id' do
    expect(report.id).to eq answer.id
  end

  it 'sets question' do
    expect(report.question).to eq question
  end

  it 'sets arguments' do
    expect(report.arguments).to eq answer.arguments
  end

  it 'sets arguments text' do
    expect(report.arguments_text).to eq 'I = 1, R = 1'
  end

  it 'sets correct answer' do
    expect(report.correct_answer).to eq answer.answer
  end

  it 'sets user answer' do
    expect(report.user_answer).to eq answer.user_answer
  end

  it 'sets correct flag' do
    expect(report.correct?).to eq answer.correct?
  end

  describe '.answers' do
    it 'returns answers' do
      expect(described_class.answers(student, test)).to contain_exactly answer, answer_wrong
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
# rubocop:enable RSpec/LetSetup
