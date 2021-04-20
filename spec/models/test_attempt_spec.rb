# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestAttempt, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :category }
    it { is_expected.to have_many :static_questions }
  end

  describe '#latest?' do
    let!(:test_attempt) { create(:test_attempt) }

    Timecop.travel(5.minutes.from_now) do
      let!(:test_attempt_last) { create(:test_attempt) }
    end

    it 'is true for latest test attempt' do
      expect(test_attempt).not_to be_latest
      expect(test_attempt_last).to be_latest
    end
  end
end
