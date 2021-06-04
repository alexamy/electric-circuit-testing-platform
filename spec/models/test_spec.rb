# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Test, type: :model do
  let(:model) { described_class }
  let(:user) { create(:user) }

  let(:test) { create(:test) }
  let(:test_other) { create(:test) }
  let(:test_empty) { create(:test) }

  let!(:question) { create(:question, test: test) }
  let!(:question_other) { create(:question, test: test_other) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :target_score }
  it { is_expected.to validate_numericality_of(:target_score).only_integer.is_greater_than(0) }

  it { is_expected.to have_many(:questions).dependent(:destroy) }
  it { is_expected.to have_many(:attempts).dependent(:nullify) }

  describe '.with_questions' do
    it 'returns only tests with questions' do
      expect(model.with_questions).to contain_exactly test, test_other
    end
  end

  describe '#score_of' do
    it 'returns 0 when no questions answered' do
      expect(test.score_of(user)).to be_zero
    end

    it 'increases score when user has correct answers' do
      create(:task, :correct, author: user, question: question)

      expect(test.score_of(user)).to be_positive
    end

    it 'decreases score when user has wrong answers' do
      create(:task, :wrong, author: user, question: question)

      expect(test.score_of(user)).to be_negative
    end

    it 'counts only its own answers' do
      create(:task, :correct, author: user, question: question_other)

      expect(test.score_of(user)).to be_zero
    end
  end
end
