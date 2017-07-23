class Marker < ActiveRecord::Base
  belongs_to :client
  
  @@allergen_list = [:dog, :cat, :mold, :bees, :perfume, :oak, :dust, :smoke, :gluten, :peanut]
  
  
  def self.delete_marker(id)
    Marker.find(id).destroy
  end
  def self.find_all_in_bounds(top, bottom, left, right)

    markersTop = Marker.where("lat < ?", top)
    markersBottom = Marker.where("lat > ?", bottom)
    markersLeft = Marker.where("lng < ?", left)
    markersRight = Marker.where("lng > ?", right)
    return  markersBottom & markersTop & markersRight & markersLeft
  end
 
  def self.find_all_in_zoom(top,bottom,left,right,lat, long)  
    
    zoom_ratio = 0.125
    zoom_lat = (top - bottom) * zoom_ratio
    zoom_long = (left - right) * zoom_ratio
    zoom_top = lat + zoom_lat
    zoom_bottom = lat - zoom_lat
    zoom_left = long + zoom_long
    zoom_right = long - zoom_long
    return self.find_all_in_bounds(zoom_top, zoom_bottom, zoom_left, zoom_right)
  end  
      
      
  def self.get_global_markers(markers,global_number_show,top,bottom,left,right)

    output = []
    # for each marker that is not listed already
    markers.each do |marker|
      unless output.include? marker
      # for each allergen listed as true
        break_test = false
        # check all other markers in zoomed in area to see if global_show - 1 are also true
        zoom_markers = self.find_all_in_zoom(top.to_f,bottom.to_f,left.to_f,right.to_f,marker.lat.to_f, marker.lng.to_f)
        # for every allergen
        @@allergen_list.each do |allergen|
          # breakout of loop if marker has been added already
          if break_test == true then break end
          allergen_count = 0
          # if the marker has this allergen ticked
          if (marker.send(allergen) == true) 
            # for every marker in the zoomed area around this marker
            zoom_markers.each do |zoom_marker|
              # if it also has this allergen ticked
              if (zoom_marker.send(allergen) == true) 
                allergen_count += 1
                if allergen_count >= global_number_show
                  # add marker to ouput if > global appear in zoomed area 
                  output << marker
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