# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

RSpec.describe QuestionSeed, type: :task do
  describe '.seed' do
    it 'populate questions' do
      expect do
        described_class.seed
      end.to change(Question, :count).by(2)
    end

    it 'start with specified index' do
      described_class.seed
      expect(Question.first.id).to eq 1
    end
  end
end
