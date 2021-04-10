# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'admin?' do
    let(:user) { create(:user) }
    let(:admin) { create(:admin) }

    it 'is false for normal user' do
      expect(user).not_to be_admin
    end

    it 'is true for admin user' do
      expect(admin).to be_admin
    end
  end
end
