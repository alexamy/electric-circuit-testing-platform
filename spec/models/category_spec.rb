# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:model) { described_class }
  let(:user) { create(:user) }

  let(:category) { create(:category) }
  let(:category_other) { create(:category) }
  let(:category_empty) { create(:category) }

  let!(:question) { create(:question, category: category) }
  let!(:question_other) { create(:question, category: category_other) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :target_score }
  it { is_expected.to validate_numericality_of(:target_score).only_integer.is_greater_than(0) }

  it { is_expected.to have_many(:questions).dependent(:destroy) }
  it { is_expected.to have_many(:test_attempts).dependent(:nullify) }

  describe '.with_questions' do
    it 'returns only categories with questions' do
      expect(model.with_questions).to contain_exactly category, category_other
    end
  end

  describe '#score_of' do
    it 'returns 0 when no questions answered' do
      expect(category.score_of(user)).to be_zero
    end

    it 'increases score when user has correct answers' do
      create(:static_question, :correct, author: user, question: question)

      expect(category.score_of(user)).to be_positive
    end

    it 'decreases score when user has wrong answers' do
      create(:static_question, :wrong, author: user, question: question)

      expect(category.score_of(user)).to be_negative
    end

    it 'counts only its own answers' do
      create(:static_question, :correct, author: user, question: question_other)

      expect(category.score_of(user)).to be_zero
    end
  end
end
