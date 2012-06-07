class ClientsController < ApplicationController
	before_filter :signed_in_user, only: [:show, :index]
	before_filter :trainer_only, only: [:index]
	
  def new
  	@client = Client.new
  end
  
  def create
  	@client = Client.new(params[:client])
  	if @client.save
  		flash[:success] = "Account created successfully"
  		redirect_to client_path(@client)
  	else
  		render 'new'
  	end
  end
  
  def show
  	@client = Client.find(params[:id])
  end
  
  def index
  	@clients = Client.paginate(page: params[:page])
  end
  
  private
  	
  	def trainer_only
			unless current_user.class == Trainer
  			redirect_to signin_path, notice: "Only Trainers authorized to view this list #{current_user.name}"
  		end
  	end
  
end
