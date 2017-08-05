class EmailConfirmController < ApplicationController
    
    def confirming
        render 'confirm_mailer/delete_email.html'
        # if (params[:num] == "2")
        #     render 'confirm_mailer/confirmed.html'
        # else
        #     render 'confirm_mailer/confirm_failed.html'
        # end
    end
    
end
