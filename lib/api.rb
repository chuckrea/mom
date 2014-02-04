module Api

  def get_forecast(user)
    

    latitude = user.latitude
    longitude = user.longitude
    url = "https://api.forecast.io/forecast/b20ed2cf518265035a434036f7522627/#{latitude},#{longitude}"
    response = JSON.parse(HTTParty.get(url).body)
    temperature = response["currently"]["temperature"]
    summary = response["currently"]["summary"]
    return "It's currently #{temperature} degrees out and #{summary}"

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
        :body => "It's Mom!  I know you don't check the weather, so here you go: " + forecast
      )
    end
  end

end
