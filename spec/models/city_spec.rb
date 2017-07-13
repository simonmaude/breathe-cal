require 'rails_helper'

RSpec.describe City, type: :model do
  describe "city#get_location_key" do
  
    # it "gets the location key" do 
    #   expect(City.get_loc_key("37.8716", "-122.2727", "Berkeley")).to eq "332044"
    # end
    
    
    # this is the non ajax version subject to change!

    #   expect(City).to receive().with("Berkeley")
    # it "calls the model method that gets the location key from accuweather" do 
    #   post :, {: => 'Berkeley'}
    # end
  end
  
  describe "city#update_daily_data" do
    
    it "updates the daily_data" do
      expect(true).to eq(true)      
    end
  
  end

end
