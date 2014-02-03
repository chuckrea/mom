class Api

  def getForecast

    @latitude = self.latitude
    @longitude = self.longitude
    url = "https://api.forecast.io/forecast/b20ed2cf518265035a434036f7522627/#{latitude},#{longitude}"
    response = JSON.parse(HTTParty.get(url).body)
    @temperature = response["currently"]["temperature"]
    @summary = response["currently"]["summary"]
    return "It's currently #{@temperature} degrees out and #{@summary}"
    
  end

end
