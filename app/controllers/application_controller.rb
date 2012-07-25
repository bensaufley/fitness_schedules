class ApplicationController < ActionController::Base
	include SessionsHelper
	include SchedulesHelper
  protect_from_forgery
end
