module SessionsHelper
	
	def sign_in(user)
		session[:user_id] = user.id
		self.current_user = user
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		if @current_user
			@current_user
		elsif Client.find_by_id(session[:user_id])
			@current_user = Client.find(session[:user_id])
		elsif Trainer.find_by_id(session[:user_id])
			@current_user = Trainer.find(session[:user_id])
		else
			nil
		end
	end
	
	def sign_out(user)
		session[:user_id] = nil
		self.current_user = nil
	end
	
end
