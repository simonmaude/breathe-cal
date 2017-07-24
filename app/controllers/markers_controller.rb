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
    current_user_id = session[:client_id]
    top = bound_params[:uplat]
    bottom = bound_params[:downlat]
    left = bound_params[:leftlong]
    right = bound_params[:rightlong]
    # search_allergen = [:allergen] 
    search_allergen = ''
    
    markers = Marker.find_all_in_bounds(top,bottom,left,right,"client_id = #{current_user_id}", search_allergen="")

    # gets all possible markers in bounds
    @marker_types_in_bounds = markers.uniq { |m| m.title }
    @marker_types_in_bounds = @marker_types_in_bounds.map { |m| m.title }
    
    # do the filtering
    if params[:filter] && (params[:filter].keys.length > 0)
      filtered_allergens = params[:filter]
      markers = markers.select { |m| filtered_allergens.include? m.title }
    end
    
    global_markers = Marker.get_global_markers(markers,global_number_show,top,bottom,left,right,search_allergen="")


    

    marker_container = [markers, global_markers, @marker_types_in_bounds]
    # pass collection to gmaps.js
    
    respond_to do |format|
      format.json { render :json => marker_container }
    end
            
  end
  
  
  private 
  
  def marker_params
    params.require(:marker).permit(:lat, :lng, :cat, :dog, :mold, :bees, :perfume, :oak, :peanut, :gluten, :dust, :smoke, :title)
  end
  
  def bound_params
    params.require(:bounds).permit(:uplat,:downlat,:rightlong,:leftlong)
  end
  
end
