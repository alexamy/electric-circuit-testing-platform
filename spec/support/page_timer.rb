# frozen_string_literal: true

# :reek:InstanceVariableAssumption
class PageTimer
  class << self
    def bind(page)
      @page = page
    end

    def respond_to_missing?
      true
    end

    def method_missing(name, *args)
      @page.execute_script("clock.#{name}(#{args.join(', ')})")
    end
  end
end
