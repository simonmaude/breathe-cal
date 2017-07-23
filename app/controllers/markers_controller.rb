class MarkersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if session[:client_id] != nil 
      marker = Marker.create!(marker_params.merge(:client_id => session[:client_id]))
      render :json => marker
    else 
      render :nothing => true
    end 
  end

  def delete 
    Marker.delete_marker(params[:id])
    render :json => Marker.all
  end
  def show
    
    global_number_show = 5
    
    top = bound_params[:uplat].to_f
    bottom = bound_params[:downlat].to_f
    
    left = bound_params[:leftlong].to_f
    right = bound_params[:rightlong].to_f
    
    markers = Marker.find_all_in_bounds(top,bottom,left,right)
    global_markers = Marker.get_global_markers(markers,global_number_show,top,bottom,left,right)
    
    # remove markers that do not belong to the current user or aren't clustered 
    markers.each do |marker|
      unless (marker.client_id == session[:client_id]) 
        markers -= [marker] 
      end
    end
    
    # duct-tape way of passing current client_id to gmaps.js - todo: refactor with better solution
    marker_container = [markers, global_markers]
    
    # duct-tape way of passing current client_id to gmaps.js - todo: refactor with better solution
    # client_id_dummy = Marker.new
    # client_id_dummy.client_id = :client_id
    # markers.insert(0, client_id_dummy)
    
    # pass collection to gmaps.js
    render :json => marker_container
    # render :json => heatmap  
            
  end
  
  
  private 
  
  def marker_params
    params.require(:marker).permit(:lat, :lng, :cat, :dog, :mold, :bees, :perfume, :oak, :peanut, :gluten, :dust, :smoke, :title)
  end
  
  def bound_params
    params.require(:bounds).permit(:uplat,:downlat,:rightlong,:leftlong)
  end
  
end
