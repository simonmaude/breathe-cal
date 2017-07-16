class Marker < ActiveRecord::Base
  belongs_to :client
  
  
  def self.find_all_within_bounds(top, bottom, left, right)
    markersTop = Marker.where("lat < (?)", top)
    markersBottom = Marker.where("lat > (?)", bottom)
    markersLeft = Marker.where("lng < ?", left)
    markersRight = Marker.where("lng > ?", right)

    return markersBottom & markersTop & markersLeft & markersRight
  end
      
  def self.distinct_count_within_bounds(list,type,top,bottom,left,right)
    return list.group(client_id).uniq.count(type)
  end
  
end