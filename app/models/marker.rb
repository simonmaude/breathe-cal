class Marker < ActiveRecord::Base
  belongs_to :client
  
  @@allergen_list = [:dog, :cat, :mold, :bees, :perfume, :oak, :dust, :smoke, :gluten, :peanut]
  
  def self.find_all_in_bounds(top, bottom, left, right)
    markersTop = Marker.where("lat < (?)", top)
    markersBottom = Marker.where("lat > (?)", bottom)
    markersLeft = Marker.where("lng < ?", left)
    markersRight = Marker.where("lng > ?", right)
    return markersBottom & markersTop & markersLeft & markersRight
  end
 
  def self.find_all_in_zoom(top,bottom,left,right)        
    zoom_lat = (top - bottom) * 0.33
    zoom_long = (right - left) * 0.33
    zoom_top = top - zoom_lat
    zoom_bottom = bottom + zoom_lat
    zoom_left = left + zoom_long
    zoom_right = right - zoom_long
    return find_all_in_bounds(zoom_top, zoom_bottom, zoom_left, zoom_right)
  end  
      
      
  def self.get_global_markers(markers,global_number_show,top,bottom,left,right)
    output = []
    # for each marker that is not listed already
    markers.each do |marker|
      unless output.include? marker
      # for each allergen listed as true
        break_test = false
        @@allergen_list.each do |allergen|
          # breakout of loop if marker has been added already
          if break_test == true then break end
          allergen_count = 0
          if marker.send(allergen) == true 
            # check all other markers in zoomed in area to see if global_show - 1 are also true
            zoom_markers = find_all_in_zoom(top,bottom,left,right)
 
            zoom_markers.each do |zoom_marker|
              if zoom_marker.allergen == true 
                allergen_count += 1 
                if allergen_count >= global_number_show
                  # add marker to ouput if > global appear in zoomed area 
                  output << marker
                  break_test = true
                  # breakout of loop if marker has been added already
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