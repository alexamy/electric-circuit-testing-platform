# frozen_string_literal: true

class StaticQuestion < ApplicationRecord
  validates :arguments, :answer, presence: true

  belongs_to :question
end
