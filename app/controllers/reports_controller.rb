class ReportsController < ApplicationController
  before_filter :is_admin 
  
  def new
  end    
  
  def create
    trainer = Trainer.find_by_email(params[:report][:email])
    first_date = get_date_from_params(params, "start_date")
    last_date = get_date_from_params(params, "end_date")
    redirect_to reports_show_path({report: {trainer_id: trainer, start_date: first_date, end_date: last_date}})
  end

  def show
    @trainer = Trainer.find(params[:report][:trainer_id])
    @schedules = @trainer.schedules # write SQL query to limit by date in params
  end
  
end
