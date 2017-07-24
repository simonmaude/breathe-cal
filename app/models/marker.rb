class Marker < ActiveRecord::Base
  belongs_to :client
  
  @@allergen_list = [:dog, :cat, :mold, :bees, :perfume, :oak, :dust, :smoke, :gluten, :peanut]
  
  def self.find_all_in_bounds(coords, id = '', search_allergen = '')
    markersTop = Marker.where("lat < (?)", coords[:top]).where(id).where(search_allergen)
    markersBottom = Marker.where("lat > (?)", coords[:bottom])
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
      
      
  def self.get_global_markers(markers, global_number_show, coords, search_allergen = '')
    output = []
    # for each marker that is not listed already
    markers.each do |marker|
      unless output.include? marker
      # for each allergen listed as true
        break_test = false
        # check all other markers in zoomed in area to see if global_show - 1 are also true
        zoom_markers = self.find_all_in_zoom(coords, marker.lat.to_f, marker.lng.to_f)
        # for every allergen
        search_allergen == '' ? (allergens = @@allergen_list) : (allergens = [search_allergen])
        allergens.each do |allergen|
          # breakout of loop if marker has multiple allergens and has been added already
          if break_test == true then break end
          allergen_count = 0
          # if the marker has this allergen checkbox ticked or title = allergen 
          if (marker.send(allergen) == true) || marker.title == allergen
            id_set = Set.new
            # for every marker in the zoomed area around this marker
            zoom_markers.each do |zoom_marker|
              # if it also has this allergen ticked
              if (zoom_marker.send(allergen) == true) || zoom_marker.title == allergen
                # if the allergen_count >= global_number_show and this user does not 
                # already have a marker for this allergen saved 
                allergen_count += 1
                if (allergen_count >= global_number_show) && (!id_set.include? marker.client_id)
                  # add marker to ouput and the client id to the user id set  
                  output << marker
                  id_set << marker.client_id
                  # breakout of loop if marker has been added already
                  break_test = true
                  break
                end
              end
            end
            
          end
        end
        
      end
    end
    return output
  end
      
  
end