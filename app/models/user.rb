# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :type, exclusion: { in: %w[User] }

  has_many :tasks, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
  has_many :attempts, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy

  def teacher?
    is_a?(Teacher)
  end

  def student?
    is_a?(Student)
  end

  def author_of?(resource)
    id == resource&.author_id
  end
end
