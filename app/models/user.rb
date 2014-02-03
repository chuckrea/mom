class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :location, :weather, :username, :phone_number
  attr_accessible :latitude, :longitude
  # attr_accessible :title, :body

  geocoded_by :location  
  after_validation :geocode

  def getForecast
  	# apiKey = "b20ed2cf518265035a434036f7522627"

	@latitude = self.latitude
	@longitude = self.longitude
	url = "https://api.forecast.io/forecast/b20ed2cf518265035a434036f7522627/#{latitude},#{longitude}"
	response = JSON.parse(HTTParty.get(url).body)
	@temperature = response["currently"]["temperature"]
	@summary = response["currently"]["summary"]
	return "It's currently #{@temperature} degrees out and #{@summary}"
  end

end
