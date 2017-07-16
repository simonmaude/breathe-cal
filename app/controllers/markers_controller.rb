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
    up = bound_params[:uplat]
    down = bound_params[:downlat]
    left = bound_params[:leftlong]
    right = bound_params[:rightlong]
    
    markers = Marker.find_all_within_bounds(up,down,left,right)
    
    markers.each do |marker|
      distinct_count = Marker.distinct_count_within_bounds(markers,marker,up,down,left,right)
      unless marker.client_id == session[:client_id] || distinct_count >= global_number_show
        markers -= marker 
      end
    end
    p markers
    render :json => markers
    # render :json => output
  end
  
  private 
  
  def marker_params
    params.require(:marker).permit(:lat, :lng, :cat, :dog, :mold, :bees, :perfume, :oak, :peanut, :gluten, :dust, :smoke, :title)
  end
  
  def bound_params
    params.require(:bounds).permit(:uplat,:downlat,:rightlong,:leftlong)
  end
  
end
