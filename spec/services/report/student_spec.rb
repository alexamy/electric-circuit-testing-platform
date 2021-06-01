# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe Report::Student, type: :service do
  let(:report) { described_class }
  let(:instance) { report.new(student, test) }
  let(:result) { report.call(student, test) }

  let(:student) { create(:student) }
  let(:test) { create(:category, name: 'Test example', target_score: 6) }
  let(:test_attempt) { create(:test_attempt, category: test, author: student) }
  let(:question) { create(:question, category: test) }
  let!(:answer) { create(:static_question, :correct, question: question, test_attempt: test_attempt, author: student) }
  let!(:answer_wrong) { create(:static_question, :wrong, question: question, test_attempt: test_attempt, author: student) }

  describe 'initialization' do
    it 'sets user' do
      expect(instance.user).to eq student
    end

    it 'sets test' do
      expect(instance.test).to eq test
    end

    it 'sets answers' do
      expect(instance.answers).to contain_exactly answer, answer_wrong
    end
  end

  describe '.call' do
    it 'sets name' do
      expect(result[:name]).to eq test.name
    end

    it 'sets target score' do
      expect(result[:target_score]).to eq test.target_score
    end

    it 'sets score' do
      expect(result[:score]).to eq(-1)
    end

    it 'sets percentage' do
      expect(result[:correctness_percentage]).to eq '50%'
    end

    it 'sets attempts count' do
      expect(result[:attempts]).to eq 1
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
