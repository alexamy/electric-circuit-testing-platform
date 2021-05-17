# frozen_string_literal: true

class Student < User
  validates :first_name, :last_name, presence: true

  belongs_to :group
end
