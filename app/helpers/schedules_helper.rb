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
  
  def rendered
    schedule = Schedule.find(params[:id])
    flash[:alert] = "This schedule is marked as complete and cannot be edited"
    redirect_to schedule unless schedule.rendered == nil
  end
    
end
