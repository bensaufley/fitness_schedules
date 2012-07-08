class SchedulesController < ApplicationController
  	
  before_filter :trainer_only, only: [:edit, :update]
  	
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
		true_client = @schedule.client
		auth_client = Client.find_by_email(params[:schedule][:client][:email])
		if params[:schedule][:rendered] == nil
			flash[:alert] = "Must choose an option"
			redirect_to @schedule
		elsif true_client == auth_client && auth_client.authenticate(params[:schedule][:client][:password])
			@schedule.rendered = params[:schedule][:rendered]
			@schedule.save
		else
			flash[:alert] = "Incorrect client authentication"
			redirect_to @schedule
		end
	end
	
end

# 		if user && user.authenticate(params[:session][:password])