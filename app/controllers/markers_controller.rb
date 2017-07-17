class MarkersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if session[:client_id] != nil 
      marker = Marker.create!(marker_params.merge(:client_id => session[:client_id]))
      render :json => marker
    else 
      render :nothing => true
    end
    #i assume i get some JSON from the post 
  end
  
  def show
    global_number_show = 5
    top = bound_params[:uplat]
    bottom = bound_params[:downlat]
    left = bound_params[:leftlong]
    right = bound_params[:rightlong]
    
    markers = Marker.find_all_in_bounds(top,bottom,left,right)
    global_markers = Marker.get_global_markers(markers,global_number_show,top,bottom,left,right)
    
    markers.each do |marker|
      unless ((marker.client_id == session[:client_id]) || (global_markers.include? marker)) 
        markers -= marker 
      end
    end
    # p markers
    render :json => markers
  end
  
  private 
  
  def marker_params
    params.require(:marker).permit(:lat, :lng, :cat, :dog, :mold, :bees, :perfume, :oak, :peanut, :gluten, :dust, :smoke, :title)
  end
  
  def bound_params
    params.require(:bounds).permit(:uplat,:downlat,:rightlong,:leftlong)
  end
  
end
