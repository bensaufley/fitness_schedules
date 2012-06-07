class ClientsController < ApplicationController
	before_filter :signed_in_user, only: [:show, :index]
	before_filter :trainer_only, only: [:index]
	before_filter :page_owner, only: [:show]
	
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
  
end
