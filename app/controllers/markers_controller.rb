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
  
  def show
    global_number_show = 5
    current_user_id = session[:client_id]
    coords = {top: bound_params[:uplat], bottom: bound_params[:downlat], 
              left: bound_params[:leftlong], right: bound_params[:rightlong]}
    # search_allergen = params[:allergen] 
    search_allergen = ''
    
    markers = Marker.find_all_in_bounds(coords,"client_id = #{current_user_id}",search_allergen)
    global_markers = Marker.get_global_markers(markers,global_number_show,coords,search_allergen)

    marker_container = [markers, global_markers]
    # pass collection to gmaps.js
    render :json => marker_container
            
  end
  
  
  private 
  
  def marker_params
    params.require(:marker).permit(:lat, :lng, :cat, :dog, :mold, :bees, :perfume, :oak, :peanut, :gluten, :dust, :smoke, :title)
  end
  
  def bound_params
    params.require(:bounds).permit(:uplat,:downlat,:rightlong,:leftlong)
  end
  
end
