class SessionsController < ApplicationController

	def new
	end
	
	def create
		user = log_in_user
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user
		else 
			flash.now[:error] = "Invalid email/password combination"
			render 'new'
		end
	end
	
	def destroy
		sign_out current_user
		redirect_to root_path
	end
	
	
	
	
	private
		
		def log_in_user
			user_type = params[:user_type]
			if user_type == "Trainer"
				user = Trainer.find_by_email(params[:session][:email])
			elsif user_type == "Client"
				user = Client.find_by_email(params[:session][:email])
			else
				flash.now[:error] = "User type invalid"
				render 'new'
			end	
		end			
end
