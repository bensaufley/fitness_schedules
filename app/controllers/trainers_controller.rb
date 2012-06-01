class TrainersController < ApplicationController
  def new
  end
  
  def show
  	@trainer = Trainer.find(params[:id])
  end
  
end
