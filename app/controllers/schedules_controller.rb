class SchedulesController < ApplicationController
  
  def show
  	@schedule = Schedule.find(params[:id])
  end
  
  def edit
  	@schedule = Schedule.find(params[:id])
  end
  
  def update
		@schedule = Schedule.find(params[:id])
		if @schedule.update_attributes(params[:schedule])
			flash[:notice] = "Successfully added exercise"
			redirect_to @schedule
		else
			render 'edit'
		end
	end
	
	def complete
		@schedule = Schedule.find(params[:id])
	end
	
end
