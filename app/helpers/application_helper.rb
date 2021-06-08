# frozen_string_literal: true

# :reek:UtilityFunction
# :reek:FeatureEnvy
module ApplicationHelper
  def seconds_to_minsec(seconds)
    return '00:00' if seconds.negative? || seconds.zero?

    seconds = seconds.to_i
    minutes = seconds / 60
    seconds_left = seconds - minutes * 60

    "#{minutes.to_s.rjust(2, '0')}:#{seconds_left.to_s.rjust(2, '0')}"
  end

  # :reek:DuplicateMethodCall
  def task_report_scheme_data(report)
    return if report.scheme.blank?

    {
      tooltip_image: rails_blob_path(report.scheme),
      hover_class: report.correct? ? 'bg-green-200' : 'bg-red-200'
    }
  end
end
