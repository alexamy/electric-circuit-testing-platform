# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationService, type: :service do
  it "::call" do
    expect(described_class).to respond_to(:call)
  end
end
