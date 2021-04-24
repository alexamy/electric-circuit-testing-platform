# frozen_string_literal: true

require 'rails_helper'

shared_examples_for 'authorable' do
  let(:model) { described_class }

  it { is_expected.to belong_to(:author).class_name('User') }
end
