# frozen_string_literal: true

module Formula
  class Validator < ApplicationService
    attr_reader :text, :entries

    def initialize(text)
      super()

      @text = text
      @entries = Formula::Normalizer.new(@text).lines
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
        eq_once = entry.count('=') == 1
        eq_inside = (1..entry.length - 2).cover?(entry.index('='))
        eq_once && eq_inside
      end
    end

    def check_assignment_target
      entries.all? do |entry|
        entry.split('=').map(&:strip).first =~ /^[a-z][a-z0-9]*$/i
      end
    end

    # :reek:FeatureEnvy
    def check_duplicate_targets
      targets = entries.map { |entry| entry.split('=').first }
      targets.count == targets.uniq.count
    end
  end
end
