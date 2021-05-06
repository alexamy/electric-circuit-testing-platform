# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:model) { described_class }

  it_behaves_like 'authorable'

  describe 'validations' do
    it { is_expected.to validate_presence_of :text }
    it { is_expected.to validate_presence_of :formula }
    it { is_expected.to validate_presence_of :formula_text }
    it { is_expected.to validate_presence_of :precision }
    it { is_expected.to validate_presence_of :answer_unit }
    it { is_expected.to validate_presence_of :scheme }

    it { is_expected.to validate_numericality_of(:precision).only_integer.is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:completion_time).only_integer.is_greater_than_or_equal_to(0) }

    it 'validates formula text'
  end

  describe 'associations' do
    it { is_expected.to belong_to :category }
    it { is_expected.to have_many(:formula_parameters).dependent(:destroy) }
    it { is_expected.to have_many(:static_questions).dependent(:nullify) }

    it { is_expected.to accept_nested_attributes_for :formula_parameters }
  end

  context 'when uploads scheme' do
    let(:question) { build(:question) }

    it 'allow upload' do
      question.scheme = create_file('spec/support/files/397KB.png')
      expect(question).to be_valid
    end

    it 'allow only images' do
      question.scheme = create_file('spec/rails_helper.rb')
      expect(question).not_to be_valid
      expect(question.errors.messages[:scheme]).to eq ['должна быть изображением']
    end

    it 'restrict files to 1 MB' do
      question.scheme = create_file('spec/support/files/1_4MB.png')
      expect(question).not_to be_valid
      expect(question.errors.messages[:scheme]).to eq ['должна занимать не более 1 мегабайта']
    end
  end

  it 'have one attached scheme' do
    expect(model.new.scheme).to be_an_instance_of ActiveStorage::Attached::One
  end

  describe 'formula parameters creation' do
    let(:author) { create(:admin) }
    let(:category) { create(:category) }

    it 'parses formula text' do
      question = model.create!(**attributes_for(:question), author: author, category: category)

      expect(question.formula).to be_present
    end

    it 'creates parameters' do
      expect do
        model.create!(**attributes_for(:question), formula_text: 'x=y', author: author, category: category)
      end.to change(FormulaParameter, :count).by(1)
    end

    describe 'formula update' do
      let!(:question) { create(:question, formula_text: 'x=y*z', author: author, category: category) }

      it 'removes unused parameters' do
        expect do
          question.update!(formula_text: 'x=y')
        end.to change(FormulaParameter, :count).by(-1)
      end

      it 'adds new parameters' do
        expect do
          question.update!(formula_text: 'x=y*z*r')
        end.to change(FormulaParameter, :count).by(1)
      end
    end
  end
end
