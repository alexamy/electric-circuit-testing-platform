# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:questions).with_foreign_key('author_id') }
  end
end
