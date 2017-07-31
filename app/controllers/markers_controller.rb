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

  def edit
    Marker.edit_marker(params[:id], params[:title])
    render :json => Marker.all
  end
  
  def show
    global_number_show = 4
    current_user_id = session[:client_id]
    coords = {top: bound_params[:uplat], bottom: bound_params[:downlat], 
              left: bound_params[:leftlong], right: bound_params[:rightlong]}
    search_allergen = params[:allergen] || ''
    # search_allergen = Marker.sanitize(params[:allergen] || '')
    
    all_markers = Marker.find_all_in_bounds(coords,'',search_allergen)
    user_markers = Marker.find_all_in_bounds(coords,"client_id = #{current_user_id}",search_allergen)
    
    # gets all possible markers in bounds
    @marker_types_in_bounds = user_markers.uniq { |m| m.title }
    @marker_types_in_bounds = @marker_types_in_bounds.map { |m| m.title }
    
#     # do the filtering
#     if params[:filter] && (params[:filter].keys.length > 0)
#       filtered_allergens = params[:filter]
#       user_markers = user_markers.select { |m| filtered_allergens.include? m.title }
#       all_markers = all_markers.select { |m| filtered_allergens.include? m.title }
#     end
    

    # if params[:allergen] && (params[:allergen].keys.length > 0)
      global_markers = Marker.get_global_markers(all_markers,global_number_show,coords,search_allergen)
    # else
      # global_markers = []
    # end
    

    # pass collection to gmaps.js
    marker_container = [user_markers, global_markers]
    
    
    # respond_to do |format|
    #   format.html
    #   format.js
    #   format.json { render :json => marker_container }
    # end
    
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
