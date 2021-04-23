# frozen_string_literal: true

module ApplicationHelper
  def seconds_to_minsec(seconds)
    return '00:00' if seconds.negative?

    seconds = seconds.to_i
    minutes = seconds / 60
    seconds_left = seconds - minutes * 60

    "#{minutes.to_s.rjust(2, '0')}:#{seconds_left.to_s.rjust(2, '0')}"
  end
end
