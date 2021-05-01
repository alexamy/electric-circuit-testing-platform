# frozen_string_literal: true

class FormulaNormalizer < ApplicationService
  def initialize(text)
    super()

    @text = text
  end

  def call
    @text.gsub(/^\n+/, '')
         .gsub(/\n+$/, '')
         .gsub(/\n\s*\n/, "\n")
  end
end
