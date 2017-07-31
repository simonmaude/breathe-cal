require 'rails_helper'

RSpec.describe MarkersController, type: :controller do

  describe "POST #create" do
    context"with valid attr" do
      it "renders marker as json" do
        post :create  , {marker: {title: "cat", lat: 10, lng: 10}}, {client_id: 1}
        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(200)
      end
    end
    
    context "while not logged in " do
      it "renders nothing" do
        post :create  , {marker: {title: "cat", lat: 10, lng: 10}}, {client_id: nil}
        expect(response.body).to be_empty
      end
    end
    
  end
  
  describe "get #show" do
    it "renders json if stuff legit" do
      get :show  , {bounds: {uplat: 20, downlat: 10, rightlong: 20, leftlong: 10}}, {client_id: 1}
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(200)
    end
    
  end
  


end
