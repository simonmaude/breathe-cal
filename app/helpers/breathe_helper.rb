module BreatheHelper
  
  POLLEN_RANGE_HASH = { 'tree' => 
              {'good' => "Good: 0",
                'low' => "Low: 1 - 14",
                'moderate' => "Moderate: 15 - 89",
                'high' => "High: 90 - 499",
                'unhealthy' => "Unhealthy: 500 - 1499",
                'hazardous' => "Hazardous: >1500"
              },
              'ragweed' => 
              {'good' => "Good: 0",
                'low' => "Low: 1 - 9",
                'moderate' => "Moderate: 10 - 49",
                'high' => "High: 50 - 249",
                'unhealthy' => "Unhealthy: 250 - 499",
                'hazardous' => "Hazardous: >500"
              },
              'grass' =>
              {'good' => "Good: 0",
                'low' => "Low: 1 - 4",
                'moderate' => "Moderate: 5 - 19",
                'high' => "High: 20 - 100",
                'unhealthy' => "Unhealthy: 100 - 199",
                'hazardous' => "Hazardous: >200 "
              },
              'mold' =>
              {'good' => "Good: 0",
                'low' => "Low: 1 - 5499",
                'moderate' => "Moderate: 6500 - 12999",
                'high' => "High: 13000 - 24999",
                'unhealthy' => "Unhealthy: 25000 - 50000",
                'hazardous' => "Hazardous: >50000"
              },
    }
  
  POLLEN_DETAIL_HASH = { 'tree' => [
      ['What it is',
    'Trees produce light, dry pollen that can be carried by the wind for miles – one of the many reasons why they wreak havoc on your allergies.'],
    ['What to watch out for', 
    'Poplar, Cottonwood and Willow are a few of the trees that fall into this category. What’s interesting is that in some species only the male trees cause a problem. Their female counterparts don’t have any pollen at all.'],
    ['What to do',
    'Consider removing any of the trees that affect you from your property.']
    ],
    'ragweed' => [
      ['What it is',
      'Ragweed is a member of the daisy family with tiny yellow-green flowers that produce vast amounts of pollen – about a million grains per plant, every single day.'],
      ['What to watch out for',
        'Ragweed is found in fields, gardens, roadsides and waste areas all over the U.S. but is the biggest problem in the East and Midwest.'],
      ['What to do about it',
      'Stay one step ahead of ragweed with the Breathe allergn app.. It allows you to find out what pollen is in the air with the daily pollen forecast.']
      ],
      'mold' => [
      ['What it is',
      'Mold grows in damp areas and reproduces through tiny, airborne spores.'],
      ['What to watch out for',
      'Any wet surfaces will attract mold and aid in reproduction. Areas to look out for include: basements, bathrooms, shower stalls, refrigerator drip trays, houseplants, humidifiers and garbage pails. Mold thrives in temperatures of 41º to 100º degrees Fahrenheit.'],
      ['What to do',
      'The key to reducing mold is to keep your home dry:
      Fix leaky faucets and pipes
      Make sure rooms are properly ventilated
      Use a vented exhaust fan to remove excess moisture
      Keep humidity levels below 50% with air conditioners and dehumidifiers
      Use cleaning solutions designed to kill mold and mildew
      ']
      ],
      'grass' => [
        ['What it is',
        'Grass produces pollen that affects outdoor allergies. It’s also easily brought indoors by wind, people and pets.'],
        ['What to watch out for',
        'There are over 1,000 species of grass in North America, but only a few produce highly allergenic pollen. The most common grasses that cause allergies are Bermuda Grass, Johnson Grass, Kentucky Bluegrass, Orchard Grass, Sweet Vernal Grass and Timothy Grass.'],
        ['What to do',
        'Keep the grass in your yard short.
Wear a mask to mow the lawn, or ask someone without allergies to help.
Think about replacing your grass lawn with low pollen ground cover - Irish Moss, Bunch and Dichondra - or pollen-free features like rocks, sand and water.']
        ],
      'precip' => [['', "Moisture makes mold grow, both indoors and out. Dust mites also thrive in humid air. But if you're allergic to pollen, humid or damp days are good. The moisture weighs down the pollen, keeping it on the ground."]],
      'wind' => [['', "Wind blows pollen into the air, causing hay fever. If you have pollen allergies, shut the windows and stay indoors on windy days."]]
      
    }
  
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
  def get_allergens(name, category)
    dict = POLLEN_RANGE_HASH
    return dict
  end
  def get_pollen_range(name, category)
    dict = POLLEN_RANGE_HASH
    if dict[name.downcase]
      if dict[name.downcase][category.downcase]
        return dict[name.downcase][category.downcase] + " pollen or spores per cubic meter"
      else
        return ""
      end
    else
      return ""
    end
    
  end
  def get_pollen_detail(name) 
    dict = POLLEN_DETAIL_HASH
    return dict[name.downcase] || []
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
  
  private
  
end
