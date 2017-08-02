class Marker < ActiveRecord::Base
  belongs_to :client
  
  @@allergen_list = [:dog, :cat, :mold, :bees, :perfume, :oak, :dust, :smoke, :gluten, :peanut]
  
  def self.edit_marker(id, new_title)
    edit = Marker.find(id)
    edit.title = new_title
    edit.save
    
    

  end
  def self.delete_marker(id)
    Marker.find(id).destroy
  end
  
  def self.find_all_in_bounds(coords, client_id = '', search_allergen = '')
    search_allergen != '' ? (search_allergen = "title = '#{search_allergen}'") : (search_allergen = '')
    markers = Marker.where(search_allergen)
                    .where(client_id)
                    .where("lat < ?", coords[:top].to_s)
                    .where("lat > ?", coords[:bottom].to_s)
                    .where("lng < ?", coords[:left].to_s)
                    .where("lng > ?", coords[:right].to_s)
    # markersBottom = Marker.where("lat > ?", coords[:bottom].to_s).where(client_id)
    # markersLeft = Marker.where("lng < ?", coords[:left].to_s).where(client_id)
    # markersRight = Marker.where("lng > ?", coords[:right].to_s).where(client_id)
    # return markersBottom & markersTop & markersRight & markersLeft
    return markers
  end
 
  # potentially speed this up by setting zoom_lat & long to be fixed numbers so caching can happen
  def self.find_all_in_zoom(coords, lat, long, search_allergen = '', client_id = '')   
    zoom_ratio = 0.125
    zoom_lat = (coords[:top].to_f - coords[:bottom].to_f) * zoom_ratio
    zoom_long = (coords[:left].to_f - coords[:right].to_f) * zoom_ratio
    zoom_coords = {top:(lat + zoom_lat), bottom:(lat - zoom_lat), left:(long + zoom_long), right:(long - zoom_long)}
    return self.find_all_in_bounds(zoom_coords, client_id, search_allergen)
  end  
      
  # for each marker that is not already in the output array, check all other markers in 
  # a zoomed in area around it to see if (global_show-1) same allergen markers exist there
  def self.get_global_markers(markers, global_number_show, coords, search_allergen = '')
    output = Set.new
    markers.each do |marker|
      unless output.include? marker
        id_set = Set.new
        id_set << marker.client_id
        client_id = "client_id != #{marker.client_id}"
        search_allergen = marker.title
        zoom_markers = self.find_all_in_zoom(coords, marker.lat.to_f, marker.lng.to_f, search_allergen, client_id)
        allergen_count = 1 
        zoom_markers.each do |zoom_marker|
          if (!id_set.include? zoom_marker.client_id)
            id_set << zoom_marker.client_id
            allergen_count += 1 
          end
          if (allergen_count >= global_number_show) 
            output << marker
            id_set = Set.new
            zoom_markers.each do |zoom_marker_to_output|
              if (!id_set.include? zoom_marker.client_id)
                id_set << zoom_marker.client_id
                output << zoom_marker 
              end
            end
            break
          end
        end
      end
    end
    output
  end
      
  
end