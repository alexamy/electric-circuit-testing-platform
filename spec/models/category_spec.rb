# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :target_score }

  it { is_expected.to have_many(:questions).dependent(:destroy) }

  describe '#score_of' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:question) { create(:question, category: category) }

    let(:category_other) { create(:category) }
    let(:question_other) { create(:question, category: category_other) }

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
