class Marker < ActiveRecord::Base
  belongs_to :client
  
  @@allergen_list = [:dog, :cat, :mold, :bees, :perfume, :oak, :dust, :smoke, :gluten, :peanut]
  
  def self.delete_marker(id)
    Marker.find(id).destroy
  end
  
  def self.find_all_in_bounds(coords, id = '', search_allergen = '')
    markersTop = Marker.where("lat < ?", coords[:top].to_s).where(id).where(search_allergen)
    markersBottom = Marker.where("lat > ?", coords[:bottom])
    markersLeft = Marker.where("lng < ?", coords[:left])
    markersRight = Marker.where("lng > ?", coords[:right])
    return markersBottom & markersTop & markersRight & markersLeft
  end
 
  def self.find_all_in_zoom(coords, lat, long)   
    zoom_ratio = 0.125
    zoom_lat = (coords[:top].to_f - coords[:bottom].to_f) * zoom_ratio
    zoom_long = (coords[:left].to_f - coords[:right].to_f) * zoom_ratio
    zoom_coords = {top:(lat + zoom_lat), bottom:(lat - zoom_lat), left:(long + zoom_long), right:(long - zoom_long)}
    return self.find_all_in_bounds(zoom_coords)
  end  
      
  # for each marker that is not already in the output array, check all other markers in 
  # a zoomed in area around it to see if (global_show-1) same allergen markers exist there
  def self.get_global_markers(markers, global_number_show, coords, search_allergen = '')
    output = Set.new
    # for each marker that is not listed already
    markers.each do |marker|
      unless output.include? marker
        zoom_markers = self.find_all_in_zoom(coords, marker.lat.to_f, marker.lng.to_f)
        search_allergen == '' ? (allergens = @@allergen_list) : (allergens = [search_allergen])
        allergens.each do |allergen|
          allergen_count = 0 
          p "test"
          if (marker.send(allergen) == true) || marker.title == allergen
            p "true"
            id_set = Set.new
            zoom_markers.each do |zoom_marker|
              if (!id_set.include? zoom_marker.client_id) && ((zoom_marker.send(allergen) == true) || zoom_marker.title == allergen)
                allergen_count += 1
                id_set << zoom_marker.client_id
                if (allergen_count >= global_number_show)
                  output << marker 
                end
              end
            end
          end
        end
        
      end
    end
    output
  end
      
  
end