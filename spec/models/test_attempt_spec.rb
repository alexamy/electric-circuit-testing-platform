# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestAttempt, type: :model do
  it_behaves_like 'authorable'

  describe 'associations' do
    it { is_expected.to belong_to :test }
    it { is_expected.to have_many :static_questions }
  end

  describe '#latest?' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:test_attempt) { create(:test_attempt, author: user) }

    Timecop.travel(5.minutes.from_now) do
      let!(:test_attempt_last) { create(:test_attempt, author: user) }
    end

    it 'is true for latest test attempt' do
      expect(test_attempt).not_to be_latest
      expect(test_attempt_last).to be_latest
    end

    it 'only checks attempts authored by user' do
      Timecop.travel(10.minutes.from_now) do
        create(:test_attempt, author: other_user)
      end

      expect(test_attempt_last).to be_latest
    end
  end
end
