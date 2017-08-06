require 'securerandom'
require 'date'

class ClientsController < ApplicationController
skip_before_action :verify_authenticity_token

  def update

    if params[:email]
      client = Client.find(params[:id])
      random_num = SecureRandom.hex(256)
      ConfirmMailer.confirm_email(client.name, params[:id], params[:email], random_num).deliver_now
      client.email = params[:email]
      client.email_key =  random_num
      client.key_creation_time =  Time.now()   
      client.save!
      render json: "success"
    end
    
    if params[:location] 
      client = Client.find(params[:id])
      client.location = params[:location] 
      client.save!
      render json: "success"
    end
      
    if params[:language]
      client = Client.find(params[:id])
      client.language = params[:language]
      client.save!
      render json: "success"
    end
  end
end