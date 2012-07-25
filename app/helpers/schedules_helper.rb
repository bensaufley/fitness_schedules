module SchedulesHelper

  def schedule_complete(schedule)
    if schedule.rendered == true
      "| Completed"
    elsif schedule.rendered == false
      "| Cancelled (within 24 hours)"
    else
      nil
    end
  end
    
end
