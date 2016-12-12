module TimeHelper
  HOUR_IN_MILLISECONDS = 3_600_000

  def format_duration(milliseconds)
    format = milliseconds < HOUR_IN_MILLISECONDS ? '%M:%S' : '%H:%M:%S'
    Time.at(milliseconds.to_f / 1000).utc.strftime(format).lstrip.gsub(/^0/, '')
  end
end
