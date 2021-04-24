# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'require_authentication' do
  it 'requires authentication' do
    action
    expect(response).to redirect_to new_user_session_path
  end
end
