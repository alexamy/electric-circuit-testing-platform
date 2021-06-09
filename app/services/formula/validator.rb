# frozen_string_literal: true

module Formula
  class Validator < ApplicationService
    attr_reader :text, :entries

    def initialize(text)
      super()

      @text = text
      @entries = Formula::Normalizer.lines(@text)
    end

    def call
      @text.present? && validators.all? { |validator| send(validator) }
    end

    private

    def validators
      private_methods(false).select { |name| name.start_with?('check_') }
    end

    # all checks start with 'check_' and automatically run in 'call'

    # :reek:FeatureEnvy
    def check_assignments
      entries.all? do |entry|
        double_equal = entry.include?('==')
        eq_inside = (1..entry.length - 2).cover?(entry.index('='))
        !double_equal && eq_inside
      end
    end

    def check_assignment_target
      entries.all? do |entry|
        entry.split('=').map(&:strip).first =~ /^[a-zа-я_][a-zа-я0-9_]*$/i
      end
    end

    # :reek:FeatureEnvy
    def check_duplicate_targets
      targets = entries.map { |entry| entry.split('=').first }
      targets.count == targets.uniq.count
    end
  end
end
