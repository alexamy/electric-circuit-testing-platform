# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :year }
    it { is_expected.to validate_numericality_of(:year).only_integer }
  end

  describe 'associations' do
    it { is_expected.to have_many(:users).dependent(:nullify) }
  end

  describe '#to_s' do
    let(:group) { create(:group, name: 'ExampleGroup', year: 2000) }

    it 'joins all attributes' do
      expect(group.to_s).to eq 'ExampleGroup (2000)'
    end
  end
end
