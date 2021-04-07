module ApplicationHelper
  def toastr_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def human_date(date)
    return date.strftime("%d/%m/%Y") unless date.nil?
  end

  def human_datetime(date)
    return date.strftime("%d/%m/%Y %H:%M:%S") unless date.nil?
  end

  def human_time(time)
    return time.strftime("%H:%M") unless time.nil?
  end

  def human_boolean(boolean)
    return boolean ? 'Sim' : 'Não'
  end

end
