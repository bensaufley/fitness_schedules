class SchedulesController < ApplicationController
  	
  before_filter :trainer_only, only: [:edit, :update]
  before_filter :schedule_owner
  before_filter :rendered, only: [:edit, :update]
  	
  def show
  	@schedule = Schedule.find(params[:id])
  end
  
  def duplicate
    schedule = Schedule.find(params[:id])
    new_schedule = schedule.dup
    new_schedule.scheduled_date = Date.today
    new_schedule.exercises << schedule.exercises.collect { |ex| ex.dup }
    new_schedule.save
    redirect_to edit_schedule_path(new_schedule)
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
			redirect_to client_path(true_client)
		else
			flash[:alert] = "Incorrect client authentication"
			redirect_to @schedule
		end
	end
	
end

