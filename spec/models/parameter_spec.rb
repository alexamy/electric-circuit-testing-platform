# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parameter, type: :model do
  describe 'validations' do
    let!(:question) { create(:question, formula_text: 'x=y', parameters: %w[y]) }

    it "isn't valid when have no corresponding question formula dependency" do
      expect(build(:parameter, name: 'I', question: question)).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to :question }
  end
end
