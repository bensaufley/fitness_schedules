class ApplicationController < ActionController::Base
	include SessionsHelper
	include SchedulesHelper
	include ReportsHelper
  protect_from_forgery
end
