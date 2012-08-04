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
		session[:return_to] = nil
		self.current_user = nil
	end
	
	def signed_in_user
		store_location
  	redirect_to signin_path, notice: "Please sign in." unless signed_in?
	end
	
	def trainer_only
		unless current_user.class == Trainer
			redirect_to signin_path, notice: "Only Trainers authorized to view this page"
		end
  end
  
  def profile_owner
 		user_model = get_model_from_params(params)
		profile_type = params[:controller]
		if profile_type == "trainers"
			redirect_to '/noauth' unless current_user == user_model.find_by_id(params[:id])
		elsif profile_type == "clients"
			if current_user.class == Client
				redirect_to '/noauth' unless current_user == user_model.find_by_id(params[:id])
			elsif current_user.class == Trainer
				redirect_to '/noauth' unless user_model.find_by_id(params[:id]).trainers.include?(current_user)
			else
				redirect_to '/noauth'
			end
		else
			redirect_to '/noauth'
		end
	end
	
	def schedule_owner
	  schedule = Schedule.find(params[:id])
	  if current_user.class == Client
	    redirect_to '/noauth' unless current_user == schedule.client
	  elsif current_user.class == Trainer
	    redirect_to '/noauth' unless schedule.trainer == current_user
	  else
	    redirect_to '/noauth'
	  end
	end
	
	def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end  
  
  def is_admin
    unless current_user.class == Trainer && current_user.admin? == true
      redirect_to '/noauth'
    end
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
