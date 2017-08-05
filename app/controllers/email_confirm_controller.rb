class EmailConfirmController < ApplicationController
    
    def confirming
        client = Client.find(params[:id])
        
        if ((params[:num] != client.email_key) || ((Time.now() - client.key_creation_time)/60 > 15))
            client.email_is_confirmed = false
            render 'confirm_mailer/confirm_failed.html'
       
        elsif ((params[:num] == client.email_key) && ((Time.now() - client.key_creation_time)/60 < 15))
            client.email_is_confirmed = true
            render 'confirm_mailer/confirmed.html'
        end
    end

    def delete_email
        client = Client.find(params[:id])
        if (params[:num] != client.email_key)
                render 'confirm_mailer/delete_email.html'
           
            elsif (params[:num] == client.email_key)
                client.email_is_confirmed = false
                render 'confirm_mailer/delete_email.html'
            end
    end

end
