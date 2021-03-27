# frozen_string_literal: true

class Parameter < ApplicationRecord
  validates :name, :minimum, :maximum, :step, :unit, presence: true

  belongs_to :question
end
