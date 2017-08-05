class ClientsController < ApplicationController
skip_before_action :verify_authenticity_token

  def update
    if params[:email] || params[:location]
      client = Client.find(params[:id])
      if params[:location] then client.location = params[:location] end
      if params[:email] then client.email = params[:email] end
      client.save!
      render json: "success"
    end 
  end

  
end
