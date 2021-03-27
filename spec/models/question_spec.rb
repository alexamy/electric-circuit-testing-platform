# frozen_string_literal: true

require "rails_helper"

RSpec.describe Question, type: :model do
  it { is_expected.to validate_presence_of :text }
  it { is_expected.to validate_presence_of :formula }

  it { is_expected.to belong_to :category }
  it { is_expected.to have_many(:formula_parameters).dependent(:destroy) }

  it { is_expected.to accept_nested_attributes_for :formula_parameters }
end
