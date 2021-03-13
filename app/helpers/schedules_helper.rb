module SchedulesHelper

  def week_day(day)
    case day
    when 'dom'
      return 0
    when 'seg'
      return 1
    when 'ter'
      return 2
    when 'qua'
      return 3
    when 'qui'
      return 4
    when 'sex'
      return 5
    when 'sab'
      return 6
    end
  end
end
