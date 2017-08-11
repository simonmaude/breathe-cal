class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  helper_method :current_client

  
  def current_client
    @current_client ||= Client.find_by_id(session[:client_id]) if session[:client_id]
  end

  private

  
end
