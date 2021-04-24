# frozen_string_literal: true

class TestAttempt < ApplicationRecord
  include Authorable

  belongs_to :category

  has_many :static_questions, dependent: :destroy

  def latest?
    TestAttempt.where(author: author).maximum(:created_at) == created_at
  end
end
