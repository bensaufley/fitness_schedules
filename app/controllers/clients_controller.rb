class ClientsController < ApplicationController
  def new
  end
  
  def show
  	@client = Client.find(params[:id])
  end
  
end
