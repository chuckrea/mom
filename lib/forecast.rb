class Weather 
	attr_accessor :location, :latitude, :longitude

	def self.forecast(location)
		apiKey = "b20ed2cf518265035a434036f7522627"

		latitude = current_user.latitude
		longitude = current_user.longitude
		url = "https://api.forecast.io/forecast/apiKey/latitude,longitude"
		return JSON.parse(HTTParty.get(url).body)
	end

end
