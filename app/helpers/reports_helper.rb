module ReportsHelper
  
  def how_rendered(schedule)
    if schedule.rendered == true
      "Complete"
    elsif schedule.rendered == nil
      "Incomplete"
    elsif schedule.rendered == false
      "Cancelled"
    else
      "Error - record not valid"
    end
  end
      
  def get_date_from_params(params, date_key)
    year = params[:report][date_key + "(1i)"]
    month = params[:report][date_key + "(2i)"]
    day = params[:report][date_key + "(3i)"]
    date_string = "#{day}/#{month}/#{year}"
    the_date = date_string.to_date
  end
  
end
