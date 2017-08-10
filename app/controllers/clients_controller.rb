require 'securerandom'
require 'date'

class ClientsController < ApplicationController
skip_before_action :verify_authenticity_token

  def update
  
    if params[:email] || params[:location] || params[:language] || params[:alerts] || params[:daily_digest]
      client = Client.find(params[:id])
     
      if params[:location] then client.location = params[:location] end
        
      if params[:email] 
        if (params[:email].length == 0)
          client.email = nil
        else
          random_num = SecureRandom.hex(256)
          ConfirmMailer.confirm_email(client.name, params[:id], params[:email], random_num).deliver_now
          client.email = params[:email]
          client.email_key =  random_num
          client.key_creation_time =  Time.now()
        end
      end
      
      if params[:language]
        client.language = params[:language]
      end
      
      if params[:alerts]
        if (params[:alerts] == "false")
          client.email_alerts = false;
        elsif (params[:alerts] == "true")
          client.email_alerts = true;
        end
      end
      
      
      if params[:daily_digest]
        if (params[:daily_digest] == "false")
          client.email_digest = false;
        elsif (params[:daily_digest] == "true")
          client.email_digest = true;
        end
      end
      
      
      client.save!
      render json: "success"
    end 
  end

  
end