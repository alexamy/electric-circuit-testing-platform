# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticQuestion, type: :model do
  let!(:question) { create(:question, formula: { dependencies: %w[R] }, completion_time: 10) }
  let(:task) { create(:static_question, question: question, created_at: Time.zone.local(2021, 1, 31, 12, 0, 0)) }

  it_behaves_like 'authorable'

  describe 'associations' do
    it { is_expected.to belong_to :question }
    it { is_expected.to belong_to :attempt }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :arguments }
    it { is_expected.to validate_presence_of :answer }

    it "isn't valid when have no corresponding question formula dependency" do
      expect(build(:static_question, arguments: { 'V' => 1 }, question: question)).not_to be_valid
    end
  end

  describe '#new_from' do
    it 'returns new static question' do
      expect(described_class.new_from(create(:question))).to be_a_new(described_class)
    end
  end

  describe '#expired?' do
    it 'is false for new task' do
      Timecop.freeze(Time.zone.local(2021, 1, 31, 12, 0, 1)) do
        expect(task).not_to be_expired
      end
    end

    it 'is true for expired task' do
      Timecop.freeze(Time.zone.local(2021, 1, 31, 12, 0, 15)) do
        expect(task).to be_expired
      end
    end
  end
end
