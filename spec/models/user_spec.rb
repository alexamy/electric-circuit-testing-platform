# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:student) { create(:student) }
  let(:teacher) { create(:teacher) }

  describe 'associations' do
    it { is_expected.to have_many(:tasks).with_foreign_key('author_id') }
    it { is_expected.to have_many(:attempts).with_foreign_key('author_id') }
  end

  describe '#teacher?' do
    it 'is false for student' do
      expect(student).not_to be_teacher
    end

    it 'is true for teacher' do
      expect(teacher).to be_teacher
    end
  end

  describe '#student?' do
    it 'is false for teacher' do
      expect(teacher).not_to be_student
    end

    it 'is true for student' do
      expect(student).to be_student
    end
  end

  describe '#author_of?' do
    let(:teacher) { create(:teacher) }
    let(:other_teacher) { create(:teacher) }

    let(:question) { create(:question, author: teacher) }
    let(:other_question) { create(:question, author: other_teacher) }

    it 'is true when asked for owned object' do
      expect(teacher).to be_author_of(question)
    end

    it "is false when asked for someone else's object" do
      expect(teacher).not_to be_author_of(other_question)
    end
  end
end
