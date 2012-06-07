module SessionsHelper
	
	def sign_in(user)
		session[:user_id] = user.id
		session[:user_class] = user.class
		self.current_user = user
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def current_user=(user)
		@current_user = user
	end
	
# 	def current_user
# 		if @current_user
# 			@current_user
# 		elsif Client.find_by_id(session[:user_id])
# 			@current_user = Client.find(session[:user_id])
# 		elsif Trainer.find_by_id(session[:user_id])
# 			@current_user = Trainer.find(session[:user_id])
# 		else
# 			nil
# 		end
# 	end
 
 	def current_user
 		if session[:user_class]
			@current_user ||= session[:user_class].find_by_id(session[:user_id])
		else
			nil
		end
	end
	
	def sign_out(user)
		session[:user_id] = nil
		session[:user_class] = nil
		self.current_user = nil
	end
	
	def signed_in_user
  	redirect_to signin_path, notice: "Please sign in." unless signed_in?
	end
	
	def trainer_only
		unless current_user.class == Trainer
			redirect_to signin_path, notice: "Only Trainers authorized to view this list"
		end
  end
  
  def page_owner
  	user_type = get_model_from_params(params)
  	redirect_to '/noauth' unless current_user == user_type.find_by_id(params[:id])  
  end
  
  private
  
  	def get_model_from_params(params)
  		controller = params[:controller]
  		if controller == "trainers"
  			Trainer
  		elsif controller == "clients"
  			Client
  		else
  			nil
  		end
  	end
  	
  	
	
end
