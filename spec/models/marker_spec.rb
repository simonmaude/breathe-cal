require 'rails_helper'

RSpec.describe Marker, type: :model do

  describe ".find_all_in_bounds" do
    it "returns no markers with impossible specs" do
      expect(Marker.find_all_in_bounds({top:10, bottom:20, left:20, right:10})).to be_empty
    end
    
    it "returns all markers in the bounds" do
      Marker.create!(lat: 15, lng: 15, title: "cat")
      Marker.create!(lat: 14, lng: 14, title: "cat")
      Marker.create!(lat: 30, lng: 30, title: "cat")
      expect(Marker.find_all_in_bounds({top:20, bottom:10, left:20, right:10}).length).to eq(2)
    end
  end
  
  describe ".find_all_in_zoom" do
    it "returns no markers with impossible specs" do
      expect(Marker.find_all_in_zoom({top:10, bottom:20, left:20, right:10},15,15)).to be_empty
    end
    
    it "returns all markers in the bounds" do
      Marker.create!(lat: 17, lng: 17, title: "cat")
      Marker.create!(lat: 16, lng: 16, title: "cat")
      Marker.create!(lat: 14, lng: 14, title: "cat")
      Marker.create!(lat: 30, lng: 30, title: "cat")
      expect(Marker.find_all_in_zoom({top:20, bottom:10, left:20, right:10},15,15,'cat').length).to eq(2)
    end
  end
  
  describe ".get_global_markers" do
    it "returns no markers if less than the global_number_show are present on the map" do
      global_number_show = 5
      Marker.create!(lat: 15, lng: 15, title: "dog")
      Marker.create!(lat: 14, lng: 14, title: "dog")
      Marker.create!(lat: 30, lng: 30, title: "dog")
      markers = Marker.find_all_in_bounds({top:20, bottom:10, left:20, right:10})
      expect(Marker.get_global_markers(markers,global_number_show,{top:20, bottom:10, left:20, right:10}).length).to eq(0)
    end
    
    it "returns no markers if less than the global_number_show are present in a zoomed area" do
      global_number_show = 5
      Marker.create!(lat: 15, lng: 15, title: "dog")
      Marker.create!(lat: 15, lng: 15, title: "dog")
      Marker.create!(lat: 15, lng: 15, title: "dog")
      Marker.create!(lat: 15, lng: 15, title: "dog")
      Marker.create!(lat: 20, lng: 20, title: "dog")
      markers = Marker.find_all_in_bounds({top:20, bottom:10, left:20, right:10})
      expect(Marker.get_global_markers(markers,global_number_show,{top:20, bottom:10, left:20, right:10}).length).to eq(0)
    end
    
    it "returns no markers if less than the global_number_show of one type are present in a zoomed area" do
      global_number_show = 5
      Marker.create!(lat: 15, lng: 15, title: "dog")
      Marker.create!(lat: 15, lng: 15, title: "dog")
      Marker.create!(lat: 15, lng: 15, title: "dog")
      Marker.create!(lat: 15, lng: 15, title: "dog")
      Marker.create!(lat: 15, lng: 15, title: "cat")
      markers = Marker.find_all_in_bounds({top:20, bottom:10, left:20, right:10})
      expect(Marker.get_global_markers(markers,global_number_show,{top:20, bottom:10, left:20, right:10}).length).to eq(0)
    end
    
    it "returns no markers if equal to the global_number_show are present in a zoomed area but not from unique client_ids" do
      global_number_show = 4
      Marker.create!(lat: 15, lng: 15, client_id: 1, title: "dog")
      Marker.create!(lat: 15, lng: 15, client_id: 2, title: "dog")
      Marker.create!(lat: 15, lng: 15, client_id: 3, title: "dog")
      Marker.create!(lat: 15, lng: 15, client_id: 3, title: "dog")
      markers = Marker.find_all_in_bounds({top:20, bottom:10, left:20, right:10})
      expect(markers.length).to eq(4)
      expect(Marker.get_global_markers(markers,global_number_show,{top:20, bottom:10, left:20, right:10}).length).to eq(0)
    end   
    
    it "returns markers if equal to the global_number_show are present in a zoomed area" do
      global_number_show = 4
      Marker.create!(lat: 15, lng: 15, client_id: 1, title: "dog")
      Marker.create!(lat: 15, lng: 15, client_id: 2, title: "dog")
      Marker.create!(lat: 15, lng: 15, client_id: 3, title: "dog")
      Marker.create!(lat: 15, lng: 15, client_id: 4, title: "dog")
      Marker.create!(lat: 19, lng: 19, client_id: 5, title: "dog")
      markers = Marker.find_all_in_bounds({top:20, bottom:10, left:20, right:10})
      expect(markers.length).to eq(5)
      expect(Marker.get_global_markers(markers,global_number_show,{top:20, bottom:10, left:20, right:10}).length).to eq(4)
    end
  end

end
