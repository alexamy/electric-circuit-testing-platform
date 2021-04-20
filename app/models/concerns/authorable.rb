# frozen_string_literal: true

module Authorable
  extend ActiveSupport::Concern

  included do
    belongs_to :author, class_name: 'User'

    scope :authored, -> { where(author: author) }
  end
end
