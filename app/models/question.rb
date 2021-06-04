# frozen_string_literal: true

class Question < ApplicationRecord
  include Authorable

  validates :text, :formula, :formula_text, :precision, :answer_unit, presence: true
  validates :scheme, presence: true, blob: { content_type: :image, size_range: 1..1.megabytes }
  validates :precision, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  validates :completion_time, allow_nil: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  validate :validates_formula_text

  belongs_to :test

  has_many :parameters, dependent: :destroy
  has_many :tasks, dependent: :nullify

  has_one_attached :scheme

  accepts_nested_attributes_for :formula_parameters

  before_validation :set_formula, if: :formula_text_changed?
  after_create :create_parameters
  before_update :remove_unused_parameters, :add_new_parameters, if: :formula_changed?

  private

  def validates_formula_text
    return unless formula_text
    return if Formula::Validator.call(formula_text)

    errors.add :formula_text, :wrong
  end

  def set_formula
    self.formula = Formula::Parser.call(formula_text)
  end

  def create_parameters
    formula['dependencies'].each do |name|
      formula_parameters.create(name: name, **Formula::Parameter.call(name))
    end
  end

  def remove_unused_parameters
    parameters = formula_parameters.reject do |parameter|
      formula['dependencies'].include?(parameter.name)
    end

    parameters.each(&:destroy)
  end

  def add_new_parameters
    parameter_names = formula_parameters.pluck(:name)

    parameters = formula['dependencies'].reject do |name|
      parameter_names.include?(name)
    end

    parameters.each do |name|
      formula_parameters.create(name: name, **Formula::Parameter.call(name))
    end
  end
end
