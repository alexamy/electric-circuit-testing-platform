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

  let!(:answer_wrong) do
    create(:static_question, :wrong, question: question, attempt: attempt, author: student,
                                     created_at: Time.zone.local(2021, 1, 31, 12, 18, 0))
  end

  let!(:answer_empty) do
    create(:static_question, question: question, attempt: attempt, author: student,
                             created_at: Time.zone.local(2021, 1, 31, 12, 18, 59))
  end

  let!(:answer) do
    create(:static_question, :correct, question: question, attempt: attempt, author: student,
                                       created_at: Time.zone.local(2021, 1, 31, 12, 15, 0),
                                       updated_at: Time.zone.local(2021, 1, 31, 12, 16, 15))
  end

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
    expect(report.arguments_text).to eq "I = 1\nR = 1"
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

  it 'sets created at' do
    expect(report.created_at).to eq answer.created_at
  end

  it 'sets answered at' do
    expect(report.answered_at).to eq answer.updated_at
  end

  it 'sets answer duration' do
    expect(report.answer_duration).to eq 75
  end

  it 'sets answer duration to nil when has no answer' do
    expect(described_class.new(answer_empty).answer_duration).to be_nil
  end

  it 'sets scheme' do
    expect(report.scheme).to eq question.scheme
  end

  describe '.answers' do
    it 'returns answers' do
      expect(described_class.answers(student, test)).to eq [answer, answer_wrong, answer_empty]
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
# rubocop:enable RSpec/LetSetup
