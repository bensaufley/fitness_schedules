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
    @schedules = sorted_schedules(params) 
  end
  
  private
  
  def sorted_schedules(params)
    sort_key = params[:sort]
    # sort_order = params[:sort][1]
    params[:report][:trainer_id].blank? ? trainer_id = Trainer.pluck(:id) : trainer_id = Trainer.find_by_id(params[:report][:trainer_id]).id
    start_date = params[:report][:start_date].to_date
    end_date = params[:report][:end_date].to_date
    if sort_key.nil?
      Schedule.find(:all, :conditions => { :scheduled_date => start_date.beginning_of_day..end_date.end_of_day, :trainer_id => trainer_id })
    elsif sort_key == "trainers" || sort_key == "clients"
      Schedule.find(:all, :include => sort_key, :order => "#{sort_key}.name", :conditions => { :scheduled_date => start_date.beginning_of_day..end_date.end_of_day, :trainer_id => trainer_id })
    elsif sort_key == "scheduled_date" || sort_key == "rendered" || sort_key == "updated_at"
      Schedule.find(:all, :order => sort_key, :conditions => { :scheduled_date => start_date.beginning_of_day..end_date.end_of_day, :trainer_id => trainer_id })
    else 
      Schedule.find(:all, :conditions => { :scheduled_date => start_date.beginning_of_day..end_date.end_of_day, :trainer_id => trainer_id })
    end
    # If Client or Trainer, need to 'join' that table: @schedules = Schedule.find(:all, :include => :trainers, :order =>'trainers.name')
    # desc or asc
  end
  
end
