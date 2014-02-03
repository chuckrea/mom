class Weather < ActiveRecord::Base
	APIKEY = "b20ed2cf518265035a434036f7522627",
	LATITUDE = "",
	LONGITUDE = "",

	url = "https://api.forecast.io/forecast/APIKEY/LATITUDE,LONGITUDE"
end