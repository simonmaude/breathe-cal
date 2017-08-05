class EmailConfirmController < ApplicationController
    
    def confirming
        render 'confirm_mailer/confirmed.html'
        # render 'confirm_mailer/confirm_failed.html'
    end
    
end
