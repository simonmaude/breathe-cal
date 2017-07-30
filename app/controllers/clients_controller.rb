class ClientsController < ApplicationController

  def update
    test_check = params[:test_check]
    if test_check
      client = Client.from_omniauth(env["omniauth.auth"])
      # client_id = params[:id]
      if params[:location] then client.location = params[:location] end
      if params[:email] then client.email = params[:email] end
      client.save!
    end 
    session[:client_id] = client.id
  end

  
end
