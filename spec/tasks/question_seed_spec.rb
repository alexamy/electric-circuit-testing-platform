# frozen_string_literal: true

require 'rails_helper'

require Rails.root.join('lib', 'tasks', 'question_seed')

RSpec.describe QuestionSeed, type: :task do
  let(:factory) { described_class }
  let!(:teacher) { create(:teacher, email: 'test@test.com') }

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

    it 'set author of questions to provided teacher' do
      seed
      Question.all.each do |question|
        expect(question.author).to eq teacher
      end
    end

    it 'raises if no teacher email provided' do
      expect { factory.seed('') }.to raise_error ArgumentError
    end
  end

  describe '.seed_by' do
    it 'returns questions' do
      expect(factory.seed_by([attributes_for(:question)])).to all be_instance_of(Question)
    end
  end
end
