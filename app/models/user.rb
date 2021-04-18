# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :static_questions, dependent: :destroy

  def admin?
    is_a?(Admin)
  end

  def author_of?(resource)
    id == resource&.author_id
  end
end
