class ReportsController < ApplicationController
  before_filter :is_admin 
  
  def new
  end    
  
  def create
    trainer = Trainer.find_by_email(params[:report][:email])
    start_date = get_date_from_params(params, "start_date")
    end_date = get_date_from_params(params, "end_date")
    redirect_to reports_show_path({report: {trainer_id: trainer, start_date: start_date, end_date: end_date}})
  end

  def show
    sort_key = params[:sort]
    sort_order = params[:direc]
    order_by = sort_string(sort_key, sort_order)
    params[:report][:trainer_id].blank? ? trainer_id = Trainer.pluck(:id) : trainer_id = Trainer.find_by_id(params[:report][:trainer_id]).id
    start_date = params[:report][:start_date].to_date
    end_date = params[:report][:end_date].to_date
    @schedules = Schedule.find(:all, :include => [:client, :trainer], :order => order_by, :conditions => { :scheduled_date => start_date.beginning_of_day..end_date.end_of_day, :trainer_id => trainer_id })
  end
  
  private
  
  def sort_string(key, dir)
    if dir == "up"
      sort_order = "ASC"
    elsif dir == "down"
      sort_order = "DESC"
    else
      sort_order = "DESC"
    end
    if key == "trainer" || key == "client"
      sort_by = "#{key}s.name #{sort_order}"
    elsif key =="scheduled_date" || key == "rendered" || key == "updated_at"
      sort_by = "#{key} #{sort_order}"
    else
      sort_by = "scheduled_date DESC"
    end
    sort_by
  end 
    
  
end

