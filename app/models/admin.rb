# frozen_string_literal: true

class Admin < User
  has_many :questions, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
end
