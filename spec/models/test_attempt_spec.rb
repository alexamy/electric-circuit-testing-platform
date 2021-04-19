# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestAttempt, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :category }
    it { is_expected.to have_many :static_questions }
  end
end
