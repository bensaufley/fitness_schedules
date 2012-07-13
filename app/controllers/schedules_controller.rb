class SchedulesController < ApplicationController
  	
  before_filter :trainer_only, only: [:edit, :update]
  before_filter :schedule_owner
  	
  def show
  	@schedule = Schedule.find(params[:id])
  end
  
  def edit
  	@schedule = Schedule.find(params[:id])
  end
  
  def update
		@schedule = Schedule.find(params[:id])
		if @schedule.rendered == nil
      if @schedule.update_attributes(params[:schedule])
        flash[:notice] = "Successfully added exercise"
        redirect_to @schedule
      else
        render 'edit'
      end
    else
      flash[:alert] = "This schedule is marked complete and may not be edited."
      redirect_to client_path(@schedule.client)
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

