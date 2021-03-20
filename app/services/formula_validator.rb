# frozen_string_literal: true

class FormulaValidator < ApplicationService
  attr_reader :text, :entries

  def initialize(text)
    super()

    @text = text
    @entries = text.split("\n").map(&:strip)
  end

  def call
    validators.all? { |validator| send(validator) }
  end

  private

  def validators
    private_methods(false).select { |name| name.start_with?('check_') }
  end

  # all checks start with 'check_' and automatically run in 'call'

  def check_assignments
    entries.all? do |entry|
      eq_once = entry.count('=') == 1
      eq_inside = (1..entry.length - 2).cover?(entry.index('='))
      eq_once && eq_inside
    end
  end

  def check_assignment_target
    entries.all? do |entry|
      entry.split('=').first =~ /^[a-z][a-z0-9]*$/i
    end
  end

  def check_duplicate_targets
    targets = entries.map { |entry| entry.split('=').first }
    targets.count == targets.uniq.count
  end
end
