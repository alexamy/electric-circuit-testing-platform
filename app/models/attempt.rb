# frozen_string_literal: true

class Attempt < ApplicationRecord
  include Authorable

  belongs_to :test

  has_many :static_questions, dependent: :destroy

  def latest?
    Attempt.where(author: author).maximum(:created_at) == created_at
  end
end
