# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:student) { create(:student) }
  let(:admin) { create(:admin) }

  describe 'associations' do
    it { is_expected.to have_many(:tasks).with_foreign_key('author_id') }
    it { is_expected.to have_many(:attempts).with_foreign_key('author_id') }
  end

  describe '#admin?' do
    it 'is false for student' do
      expect(student).not_to be_admin
    end

    it 'is true for admin' do
      expect(admin).to be_admin
    end
  end

  describe '#student?' do
    it 'is false for admin' do
      expect(admin).not_to be_student
    end

    it 'is true for student' do
      expect(student).to be_student
    end
  end

  describe '#author_of?' do
    let(:admin) { create(:admin) }
    let(:other_admin) { create(:admin) }

    let(:question) { create(:question, author: admin) }
    let(:other_question) { create(:question, author: other_admin) }

    it 'is true when asked for owned object' do
      expect(admin).to be_author_of(question)
    end

    it "is false when asked for someone else's object" do
      expect(admin).not_to be_author_of(other_question)
    end
  end
end
