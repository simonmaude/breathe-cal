class CitiesController < ApplicationController
    
    skip_before_action :verify_authenticity_token

    
    def index
    end
    
    def new
    end
  
    def cached_city_data
      city = City.find_by(name: params[:name])
      city.update_city_data
      @geo = [city.lat, city.lng]
      @data = [city.name, city.daily_data]
      @cached = true
      respond_to do |format|
        format.js {
          render :template => "cities/city_data.js.erb"
        }
      end
    end
    
    def a_in_b_as_c?(a, b, c) # a in b as c
      b.each do |i|
        if i[c] == a
          return true
        end
      end
      return false
    end
    
    def city_data
      if params[:geo]
        latlng = params[:geo]
        loc_key = City.get_loc_key(latlng["lat"], latlng["lng"], params[:name])
        city = City.find_by(location_key: loc_key)
      end
      city.update_city_data
      @data = [city.name, city.daily_data]
      unless a_in_b_as_c?(city.name, session[:cities], "name")
        if (@quality.nil?)
          @quality = city.daily_data["DailyForecasts"][0]["AirAndPollen"][0]["Category"]
        end
        session[:cities] << { "name" => city.name, "quality" => @quality }
      end
    
      respond_to do |format|
        format.js {
          render :template => "cities/city_data.js.erb"
        }
      end
      # render :json => city.daily_data.to_json
    end
    
    def city_data_back
      @text = "Recent Searches"
      if session[:cities] && session[:cities].length > 5
        session[:cities] = session[:cities][session[:cities].length - 5, session[:cities].length - 1]
        @cities = session[:cities].reverse
      else
        @cities = []
        session[:cities] = []
      end
      respond_to do |format|
        format.js {
          render :template => "cities/city_data_back.js.erb"
        }
      end      
    end
    
    def display_favorite_cities
      @text = "Favorite Cities"
      if session[:client_id]
        @cities = session[:favorites]
        if @cities == nil || @cities.empty? 
          @no_cities = "You currently have no favorite cities!"
        end
      else 
        @cities = []
        @no_cities = "Please login in order to favorite a city!"
      end
      respond_to do |format|
        format.js {
          render :template => "cities/city_data_back.js.erb"
        }
      end
    end


    def favorite_city
      city = City.find_by(name: params[:name])
      if session[:client_id]
        client = Client.find_by(id: session[:client_id])
        if (@quality.nil?)
          @quality = city.daily_data["DailyForecasts"][0]["AirAndPollen"][0]["Category"]
        end
        
        if session[:favorites]
          remove = params[:remove]
          if remove == "true"
            session[:favorites].each do |favorite_city| 
                if favorite_city['name'] == params[:name]
                  session[:favorites].delete(favorite_city)
                  client.cities.delete(city)
                end
            end
            flash.now[:notice] = "Removed " + params[:name] + " from your favorite cities!"
          else
            unless a_in_b_as_c?(city.name, session[:favorites], "name")
              session[:favorites] << { "name" => city.name, "quality" => @quality }
              client.cities << city
              flash.now[:notice] = "Added " + params[:name] + " to your favorite cities!"
            else
              flash.now[:notice] = params[:name] + " is already one of your favorite cities!"
            end
          end
        else
          session[:favorites] = []
          session[:favorites] << { "name" => city.name, "quality" => @quality }
          client.cities << city
          flash.now[:notice] = "Added " + params[:name] + " to your favorite cities!"
        end
      else
        #need to figure out how to redirect to google oauth page
        flash.now[:notice] = "You must be logged in order to favorite a city!"
      end
      @data = [city.name, city.daily_data]
      respond_to do |format|
        format.js {
          render :template => "cities/city_data.js.erb"
        }
      end
    end
      

    
    def create
      # if params[:city]
      #   City.get_location_key(params[:city]["zip"],params[:city]["name"],params[:city]["state"],params[:city]["country"])
      #   city = City.find_by(params[:location_info])
      latlng = params[:geo]
      loc_key = City.get_loc_key(latlng["lat"], latlng["lng"], params[:name])
      city = City.find_by(location_key: loc_key)
      city.update_city_data
      respond_to do |format|
        format.html {redirect_to city_path id: city.id}
        format.json {render :json => city.daily_data.to_json}
      end
    end
  
  
    def show
      @city = City.find(params[:id])
      @city.update_city_data
      @city.reload
      daily_data = @city.daily_data
      forecasts = daily_data["DailyForecasts"] 
      d1 = forecasts[0]["AirAndPollen"]
      d2 = forecasts[1]["AirAndPollen"]
      d3 = forecasts[2]["AirAndPollen"]
      d4 = forecasts[3]["AirAndPollen"]
      d5 = forecasts[4]["AirAndPollen"]
      @forecasts = [d1,d2,d3,d4,d5]
    end
    
end
