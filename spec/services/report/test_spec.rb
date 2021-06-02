# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Report::Test, type: :service do
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

  it 'sets answers' do
    expect(report.answers).to contain_exactly answer, answer_wrong
  end
end
