class ClientsController < ApplicationController

  def update
    if params[:email] || params[:location]
      client = Client.from_omniauth(env["omniauth.auth"])
      # client_id = params[:id]
      if params[:location] then client.location = params[:location] end
      if params[:email] then client.email = params[:email] end
      client.save!
      return JSON.stringify({success: "success"})
    end 
    # session[:client_id] = client.id
  end

  
end
