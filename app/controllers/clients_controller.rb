class ClientsController < ApplicationController
  def new
  	@client = Client.new
  end
  
  def show
  	@client = Client.find(params[:id])
  end
  
end
