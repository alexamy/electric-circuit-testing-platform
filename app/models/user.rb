# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :type, exclusion: { in: %w[User] }

  has_many :static_questions, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
  has_many :test_attempts, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy

  def admin?
    is_a?(Admin)
  end

  def student?
    is_a?(Student)
  end

  def author_of?(resource)
    id == resource&.author_id
  end
end
