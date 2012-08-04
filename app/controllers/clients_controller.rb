class ClientsController < ApplicationController
	before_filter :signed_in_user, only: [:show, :index]
	before_filter :trainer_only, only: [:index, :edit, :update]
	before_filter :profile_owner, only: [:show, :edit, :update]
	
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
  	@clients = Client.paginate(:page => params[:page])
  end
	
	def edit
		@client = Client.find(params[:id])
	end
	
	def update
		@client = Client.find(params[:id])
		add_trainer_id_to_new_schedule
		if @client.update_attributes(params[:client])
			flash[:notice] = "Successfully added schedule"
			redirect_to @client
		else
			render 'edit'
		end
	end
	
	def add_trainer
		client = Client.find(params[:id])
		current_user.clients << client
		redirect_to client_path(client)
	end
	
	def remove_trainer
		client = Client.find(params[:id])
		current_user.clients.delete(client)
		redirect_to trainer_path(current_user)
	end
	
end
