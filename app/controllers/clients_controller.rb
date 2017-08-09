require 'securerandom'
require 'date'

class ClientsController < ApplicationController
skip_before_action :verify_authenticity_token

  def update
  
    if params[:email] || params[:location] || params[:language]
      client = Client.find(params[:id])
     
      if params[:location] 
        location_key = City.get_loc_key(params[:lat], params[:lng], params[:location])
        client.location = params[:location] 
        client.loc_key = location_key
      end
        
      if params[:email] 
        random_num = SecureRandom.hex(256)
        ConfirmMailer.confirm_email(client.name, params[:id], params[:email], random_num).deliver_now
        client.email = params[:email]
        client.email_key =  random_num
        client.key_creation_time =  Time.now()
      end
      
      if params[:language]
        client.language = params[:language]
      end
      
      client.save!
      render json: "success"
    end 
  end

  
end