require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
    
    describe 'flow of one city' do
        before :each do
            @city = City.new(name: "Berkeley", lat: "37.8716", lng: "-122.2727", location_key: "332044", daily_data: "")
            @city.save!
        end
   
        describe '#cached_city_data' do
            it 'should render the correct template' do
                get :cached_city_data, name: @city.name, format: 'js'
                expect(response).to render_template("cities/city_data.js.erb")
            end
        end 
        
        describe '#city_data' do
            it 'when the recent searches does not contain the city being searched' do
                get :cached_city_data, name: @city.name, format:'js'
                latlng = {"lng" => @city.lng, "lat" => @city.lat}
                request.session[:cities] = [{"name" => "Albany"}]
                controller.instance_variable_set(:@quality, 'something')
                get :city_data, name: @city.name, geo: latlng,format: 'js'
                expect(response).to render_template('cities/city_data.js.erb')
            end
            
            it 'when the recent searches does contain the city being searched' do
                latlng = {"lng" => @city.lng, "lat" => @city.lat}
                request.session[:cities] = [{"name" => "Berkeley"}]
                controller.instance_variable_set(:@quality, 'something')
                get :city_data, name: @city.name, geo: latlng, format: 'js'
                expect(response).to render_template('cities/city_data.js.erb')
            end
        end
        
        describe 'favorite_cities' do
            context 'the user is signed in' do
                before :each do
                    @client =  Client.new(name: 'Joseph Brodsky', provider: 'google_oauth2', oauth_token: 'some_token', oauth_expires_at: 'July 1 2017')
                    @client.save!
                end 
                
                describe 'the user has added favorites before' do
                    it 'favorites contains this city' do
                        request.session[:client_id] = @client.id
                        request.session[:favorites] = [{"name" => 'Berkeley'}]
                        controller.instance_variable_set(:@quality, 'something')
                        get :favorite_city, name: @city.name, format: 'js'
                        expect(response).to render_template('cities/city_data.js.erb')
                    end
                    
                    it 'favorites do not contain this city' do
                        request.session[:client_id] = @client.id
                        request.session[:favorites] = [{"name" => 'not Berkeley'}]
                        controller.instance_variable_set(:@quality, 'something')
                        get :favorite_city, name: @city.name, format: 'js'
                        expect(response).to render_template('cities/city_data.js.erb')
                    end
                    
                    it 'favorites should contain the city now' do
                        request.session[:favorites] = [{"name" => 'not Berkeley'}]
                        get :display_favorite_cities, format: 'js'
                        expect(response).to render_template('cities/city_data_back.js.erb')
                    end
                end
                
                describe 'the user has not added any favorites yet' do
                    it 'no favorites should be displayed yet' do
                        request.session[:favorites] = nil
                        get :display_favorite_cities, format: 'js'
                        expect(response).to render_template('cities/city_data_back.js.erb')
                    end
                    
                    it 'no favorites yet but signed in' do
                        request.session[:client_id] = @client.id
                        request.session[:favorites] = nil
                        controller.instance_variable_set(:@quality, 'something')
                        get :favorite_city, name: @city.name, format: 'js'
                        expect(response).to render_template('cities/city_data.js.erb')
                    end
                    
                end 
            end
            
            context 'the user is not signed in' do
                it 'he can not add a favorite this way' do
                    request.session[:client_id] = nil
                    get :favorite_city, name: @city.name, format: 'js'
                    expect(response).to render_template('cities/city_data.js.erb')
                end
            end 
        end
        
        describe '#city_data_back' do
            it 'more than 5 cities have been searched for' do
                request.session[:cities] = [{"name" => '1'}, {"name" => '2'}, {"name" => '3'}, {"name" => '4'}, {"name" => '5'}, {"name" => '6'}]
                get :city_data_back, format: 'js'
            end
            
            it 'less that 5 cities have been searched for' do
                request.session[:cities] = [{"name" => '1'}]
                get :city_data_back, format: 'js'
            end
            
            it 'no cities have been searched for yet' do
                get :city_data_back, format: 'js'
            end
        end
        
        describe '#create' do
            it 'when lat and long are passed and format is json' do
                latlng = {"lng" => @city.lng, "lat" => @city.lat}
                post :create, geo: latlng, name: @city.name, format: 'json'
                expect(response).to be_success
            end 
            
            it 'when lat and long are passed and format is html' do
                latlng = {"lng" => @city.lng, "lat" => @city.lat}
                post :create, geo: latlng, name: @city.name, format: 'html'
                expect(response).to redirect_to(city_path(id: @city.id))
            end
        end
        
        describe '#show' do
            it 'when the data is being passed properly' do
                @city.daily_data= {"DailyForecasts" => [{"AirAndPollen" => 'fine'}, {"AirAndPollen" => 'fine'}, {"AirAndPollen" => 'fine'}, {"AirAndPollen" => 'fine'}, {"AirAndPollen" => 'fine'}]}
                @city.save!
                @city.update_attribute("daily_data", {"DailyForecasts" => [{"AirAndPollen" => 'fine'}, {"AirAndPollen" => 'fine'}, {"AirAndPollen" => 'fine'}, {"AirAndPollen" => 'fine'}, {"AirAndPollen" => 'fine'}]})
                get :show, id: @city.id
            end
        end
        
    end
    
end
