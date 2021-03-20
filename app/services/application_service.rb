# frozen_string_literal: true

# brakeman can't parse argument forwarding, see https://github.com/seattlerb/ruby_parser/pull/316
# rubocop:disable Style/ArgumentsForwarding

class ApplicationService
  def self.call(*args, **kws, &block)
    new(*args, **kws, &block).call
  end
end

# rubocop:enable Style/ArgumentsForwarding
