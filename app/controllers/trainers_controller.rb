class TrainersController < ApplicationController
	before_filter :signed_in_user, only: [:show]
	before_filter :profile_owner, only: [:show]
	
  def new
  	@trainer = Trainer.new
  end
  
  def create
  	@trainer = Trainer.new(params[:trainer])
  	if @trainer.save
  		flash[:success] = "Account successfully created"
  		redirect_to @trainer
  	else
  		render 'new'
  	end
  end
  
  def show
  	@trainer = Trainer.find(params[:id])
  end
  	
end
