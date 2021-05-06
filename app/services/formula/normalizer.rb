# frozen_string_literal: true

module Formula
  class Normalizer
    class << self
      def normalize(text)
        text.gsub(/^\n+/, '').gsub(/\n+$/, '').gsub(/\n\s*\n/, "\n")
      end

      def lines(text)
        normalize(text).split("\n").map(&:strip)
      end
    end
  end
end
