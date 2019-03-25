require 'time'

module DateTimeHelper
  def format_date(datetime)
    now = Time.now
    create_time = Time.at(datetime)
    if now.yday == create_time.yday &&
       now.year == create_time.year
      # create_time was today - render time as '<duration> ago'
      time_since = now - create_time
      hours = time_since.to_i / 3600
      minutes = time_since.to_i / 60 - 60 * hours
      duration = hours > 0 ? hours.to_s + ' Hours and ' : ''
      duration += minutes.to_s + ' Minutes ago'
    else
      create_time.strftime('%B %-d, %C%y at %-l:%M %P')
    end
  end
end
