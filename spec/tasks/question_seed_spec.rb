# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

RSpec.describe QuestionSeed, type: :task do
  let(:factory) { described_class }

  describe '.seed' do
    it 'populate questions' do
      expect do
        factory.seed
      end.to change(Question, :count).by_at_least(1)
    end

    it 'start with specified index' do
      factory.seed
      expect(Question.first.id).to eq 1
    end

    it 'ignores existing questions' do
      factory.seed
      expect { factory.seed }.not_to change(Question, :count)
    end
  end

  describe '.seed_by' do
    it 'returns questions' do
      expect(factory.seed_by([attributes_for(:question)], 1)).to all be_instance_of(Question)
    end
  end

  describe '.data' do
    it 'returns modules' do
      expect(factory.data).to all be_instance_of(Module)
    end

    it 'returns valid modules' do
      factory.data.each do |result|
        expect(result::QUESTIONS).to be_present
        expect(result::START_ID).to be_present
      end
    end
  end
end
