module Api

  def get_farmersmarkets(user)

    # ZIP - data info
      url = "https://data.ny.gov/resource/farmersmarkets.json?zip=#{user.zip_code}"
      response = HTTParty.get(url)
      farmersmarkets = JSON(response.body)

      farmersmarkets.each do |market|
        mkt = FarmersMarket.create(location: market["location"], market_name: market["market_name"], operation_hours: market["operation_hours"])
        user.farmers_markets << mkt
      end
  end

  def get_restaurants(user)

    Yelp.configure(:yws_id          => '55vsTZcAU8kH_LEQj_oIjA',
              :consumer_key    => 'I7sXrBiqGJXGNmZGMeOiJQ',
              :consumer_secret => 'JdMoZU8iGn6iQlvuP2Mk5-EsPt8',
              :token          => '-_031yEPjKzFSJuzTovFdp0M5RufpYC1',
              :token_secret    => 'USpbVVJmAEWq_m4mykUJbcK4kNc')


    client = Yelp::Client.new

    include Yelp::V2::Search::Request

    request = GeoPoint.new(
       :term => "restaurant",  
       :latitude => user.latitude,  
       :longitude => user.longitude,  
       :limit => 15,  
       :sort => 1)  

    response = client.search(request)

    response["businesses"].each do |biz|
      yelp = YelpInfo.create(restaurant_name: biz["name"], cuisine_type: biz["categories"][0][0], address: biz["location"]["display_address"])
      user.yelp_infos << yelp
    end
    # # Name
    # name = response["businesses"][0]["name"]
    # # Address
    # address = response["businesses"][0]["location"]["display_address"]
    # # Category
    # category = response['businesses'][0]["categories"][1][0]

  end

  def get_forecast(user)
    latitude = user.latitude
    longitude = user.longitude
    url = "https://api.forecast.io/forecast/b20ed2cf518265035a434036f7522627/#{latitude},#{longitude}"
    response = JSON.parse(HTTParty.get(url).body)
    temperature = response["currently"]["temperature"]
    summary = response["currently"]["summary"].downcase

    case  
      when temperature < 0 
        return "Your weather forecast for today is #{temperature} degrees and #{summary}. It's freezing outside! I'm coming over."
      when temperature < 25 &&  temperature > 0 
        return "Your weather forecast for today is #{temperature} degrees and #{summary}. Don't even think about leaving home without a scarf."
      when temperature < 50 && temperature > 25
        return "Your weather forecast for today is #{temperature} degrees and #{summary}. That's pretty chilly. Better not forget your coat!"
      when temperature < 70 && temperature > 50 
        return "Your weather forecast for today is #{temperature} degrees and #{summary}. Do your mother a favor, grab a sweater."
      when temperature > 70 
        return "Your weather forecast for today is #{temperature} degrees and #{summary}. Who's hungry?"
      end
  end

  def send_weather_texts

    account_sid = 'AC2e3cd4670d5a455fb0e6da2e5ddd5eeb'
    auth_token = 'b40b07ba1a2d3d92bb5e9e2c77330c3b'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    users = User.all
    users.each do |user|
      forecast = get_forecast(user)
      @client.account.messages.create(
        :from => '+16463623890',
        :to => user.phone_number,
        :body => forecast
      )
    end
  end

end
