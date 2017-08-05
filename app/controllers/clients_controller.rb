require 'securerandom'

class ClientsController < ApplicationController
skip_before_action :verify_authenticity_token

  def update

    if params[:email] || params[:location]
      client = Client.find(params[:id])
      if params[:location] then client.location = params[:location] end
        
      if params[:email] 
        random_num = SecureRandom.hex(256)
        ConfirmMailer.confirm_email(client.name, params[:id], params[:email], random_num).deliver_now
        client.email = params[:email]
        client.email_key =  random_num
      end
      
      client.save!
      render json: "success"
    end 
  end

  
end