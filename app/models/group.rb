# frozen_string_literal: true

class Group < ApplicationRecord
  validates :name, :year, presence: true
  validates :year, numericality: { only_integer: true }

  has_many :users, dependent: :nullify
end
