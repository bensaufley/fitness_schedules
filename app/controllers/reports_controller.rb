class ReportsController < ApplicationController
  before_filter :is_admin 
  
  def new
  end    
  
  def create
    trainer = Trainer.find_by_email(params[:report][:email])
    redirect_to reports_show_path({trainer_id: trainer})
  end

  def show
    @trainer = Trainer.find(params[:trainer_id])
  end
  
end
