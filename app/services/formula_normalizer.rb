# frozen_string_literal: true

class FormulaNormalizer
  attr_reader :text, :lines

  def initialize(text)
    @text = text

    normalize
    split_lines
  end

  private

  def normalize
    @text = @text.gsub(/^\n+/, '').gsub(/\n+$/, '').gsub(/\n\s*\n/, "\n")
  end

  def split_lines
    @lines = @text.split("\n").map(&:strip)
  end
end
