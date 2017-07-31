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
  
  def self.find_all_in_bounds(coords, id = '', search_allergen = '')
    search_allergen != '' ? (search_allergen = "title = '#{search_allergen}'") : (search_allergen = '')
    markersTop = Marker.where("lat < ?", coords[:top].to_s).where(id).where(search_allergen)
    markersBottom = Marker.where("lat > ?", coords[:bottom].to_s)
    markersLeft = Marker.where("lng < ?", coords[:left].to_s)
    markersRight = Marker.where("lng > ?", coords[:right].to_s)
    return markersBottom & markersTop & markersRight & markersLeft
  end
 
  def self.find_all_in_zoom(coords, lat, long, search_allergen = '')   
    zoom_ratio = 0.125
    zoom_lat = (coords[:top].to_f - coords[:bottom].to_f) * zoom_ratio
    zoom_long = (coords[:left].to_f - coords[:right].to_f) * zoom_ratio
    zoom_coords = {top:(lat + zoom_lat), bottom:(lat - zoom_lat), left:(long + zoom_long), right:(long - zoom_long)}
    return self.find_all_in_bounds(zoom_coords, '', search_allergen)
  end  
      
  # for each marker that is not already in the output array, check all other markers in 
  # a zoomed in area around it to see if (global_show-1) same allergen markers exist there
  def self.get_global_markers(markers, global_number_show, coords, search_allergen = '')
    output = Set.new
    markers.each do |marker|
      unless output.include? marker
        zoom_markers = self.find_all_in_zoom(coords, marker.lat.to_f, marker.lng.to_f, search_allergen)
        allergen_count = 0 
        id_set = Set.new
        zoom_markers.each do |zoom_marker|
          if (!id_set.include? zoom_marker.client_id)
            allergen_count += 1
            id_set << zoom_marker.client_id
            if (allergen_count >= global_number_show)
              output << marker
            end
          end
        end
      end
    end
    output
  end
      
  
end