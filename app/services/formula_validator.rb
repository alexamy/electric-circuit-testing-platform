# frozen_string_literal: true

class FormulaValidator < ApplicationService
  attr_reader :text

  def initialize(text)
    super()
    @text = text
  end

  def call
    validators.all? { |validator| send(validator) }
  end

  private

  def validators
    private_methods(false).select { |name| name.start_with?('check_') }
  end

  # all checks start with 'check_' and automatically run in 'call'
  def check_sample
    true
  end
end
