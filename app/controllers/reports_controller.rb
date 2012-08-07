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
    @trainer = Trainer.find_by_id(params[:report][:trainer_id])
    start_date = params[:report][:start_date].to_date
    end_date = params[:report][:end_date].to_date
    @schedules = Schedule.order(params[:sort]).find(:all, :conditions => { :scheduled_date => start_date.beginning_of_day..end_date.end_of_day })
    if @trainer
      client_ids = @trainer.client_ids
      @schedules = Schedule.order(params[:sort]).find(:all, :conditions => { :scheduled_date => start_date.beginning_of_day..end_date.end_of_day, :client_id => client_ids })
    end
  end
  
end
