module BreatheHelper
  def greeting1(data)
    if data.nil?
      "Hello guest!"
    else
      "In " + data[0]
    end
  end
  def greeting2(data)
    if data.nil?
      "find important allergy information here!"
    else
      "Air Quality Levels are " + air_quality(data)
    end
  end
  def air_quality(data)
    unless data.nil?
      data[1]["DailyForecasts"][0]["AirAndPollen"][0]["Category"]
    else
      "Unknown"
    end
  end
  def get_weather_text(data)
    if data.nil?
      "Error"
    else
      data[1]["DailyForecasts"][0]["Day"]["LongPhrase"]
    end
  end
  def get_weather_num(data)
    if data.nil?
      "Error"
    else
      min = data[1]["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"]
      max = data[1]["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"]
      ave = (min + max) / 2
      # assume from api response, min and max have same unit
      ave.round.to_s + data[1]["DailyForecasts"][0]["Temperature"]["Minimum"]["Unit"] + " | " + data[1]["Headline"]["Category"].capitalize
    end    
  end
  def get_weather_image(data)
    if data.nil?
      "Error"
    else
      s = (data[1]["DailyForecasts"][0]["Day"]["Icon"]).to_s
      if s.size == 1
        "0" + s + "-s.png"
      else
        s + "-s.png"
      end
    end    
  end
  def get_pollen(data)
    data[1]["DailyForecasts"][0]["AirAndPollen"]
  end
  def get_fox_image(data)
    c = air_quality(data)
    if c != "Unknown"
      c.downcase + ".png"
    else
      "low.png"
    end
  end
  def get_quality_color(q)
      m = {"good" => "badfc2", "low" => "baded8", "moderate" => "dcd8c2", "high" => "deccc0", "unhealthy" => "e1bdbe", "hazardous" => "c1beda"}
      m[q.downcase]    
  end
  def get_fox_color(data)
    c = air_quality(data)
    if c != "Unknown"
      m = {"good" => "badfc2", "low" => "baded8", "moderate" => "dcd8c2", "high" => "deccc0", "unhealthy" => "e1bdbe", "hazardous" => "c1beda"}
      m[c.downcase]
    else
      "baded8"
    end
  end

  def get_allergen_image(a)
    a.downcase + ".png"
  end
  def get_wind(data)
    if data.nil?
      "Error"
    else
      s = data[1]["DailyForecasts"][0]["Day"]["Wind"]["Speed"]
      s["Value"].to_s + " " + s["Unit"]
    end
  end
  def get_precip(data)
    if data.nil?
      "Error"
    else
      s = data[1]["DailyForecasts"][0]["Day"]["PrecipitationProbability"]
      s.to_s + "%"
    end
  end  
  def get_humid(data)
    if data.nil?
      "Error"
    else
      s = data[1]["DailyForecasts"][0]["Day"]["PrecipitationProbability"]
      s.to_s + "%"
    end
  end
  def get_other_forecasts(data)
    rtn = []
    if data.nil?
      return []
    else
      s = data[1]["DailyForecasts"]
      (1...s.size).each do |i|
        t = s[i]
        Time::DATE_FORMATS[:custom2] = lambda { |time| time.strftime("%b #{time.day.ordinalize}, %Y") }
        rtn << [DateTime.iso8601(t["Date"]).to_formatted_s(:custom2), t["AirAndPollen"][0]["Category"]]
      end
      return rtn
    end    
  end
end