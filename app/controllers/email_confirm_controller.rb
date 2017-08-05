class EmailConfirmController < ApplicationController
    
    def confirming
        client = Client.find(params[:id])
        if (params[:num] == client.email_key)
            render 'confirm_mailer/confirmed.html'
        else
            render 'confirm_mailer/confirm_failed.html'
        end
    end

end
