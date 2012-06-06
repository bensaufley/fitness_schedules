class ApplicationController < ActionController::Base
	include SessionsHelper
  protect_from_forgery
  
  def signed_in_user
  	redirect_to signin_path, notice: "Please sign in." unless signed_in?
	end
	
end
