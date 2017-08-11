class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :prepare_for_mobile
  
  helper_method :current_client

  
  def current_client
    @current_client ||= Client.find_by_id(session[:client_id]) if session[:client_id]
  end

  private
  
  def mobile_device?

  end
  helper_method :mobile_device?

  def prepare_for_mobile
    # session[:mobile_param] = params[:mobile] if params[:mobile]
    # request.format = :mobile if mobile_device? && !request.xhr?
  end
  
end
