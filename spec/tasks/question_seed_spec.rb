# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

RSpec.describe QuestionSeed, type: :task do
  let(:factory) { described_class }
  let!(:admin) { create(:admin, email: 'test@test.com') }

  describe '.seed' do
    let(:seed) { factory.seed('test@test.com') }

    it 'populates tests' do
      expect { seed }.to change(Test, :count).by_at_least(1)
    end

    it 'doesnt raise error' do
      expect { seed }.not_to raise_error
    end

    it 'populates questions' do
      expect { seed }.to change(Question, :count).by_at_least(1)
    end

    it 'ignores existing records' do
      factory.seed('test@test.com')
      expect { factory.seed('test@test.com') }.not_to raise_error
    end

    it 'set author of questions to provided admin' do
      seed
      Question.all.each do |question|
        expect(question.author).to eq admin
      end
    end

    it 'raises if no admin email provided' do
      expect { factory.seed('') }.to raise_error ArgumentError
    end
  end

  describe '.seed_by' do
    it 'returns questions' do
      expect(factory.seed_by({ 1 => attributes_for(:question) })).to all be_instance_of(Question)
    end
  end

  describe '.data' do
    it 'returns modules' do
      expect(factory.data).to all be_instance_of(Module)
    end

    it 'returns valid modules' do
      factory.data.each do |result|
        expect(result::TEST).to be_present
        expect(result::QUESTIONS).to be_present
      end
    end
  end
end
