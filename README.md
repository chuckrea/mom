# Mom.com
***"Because I never liked that Siri and I just don't think she's good enough for you!"***

##Description
<hr>
A slightly passive aggressive text based reminder service providing users with location specific forecasts, restaurant recommendations and transportation updates.


##APIs & Gems
<hr>
### APIs:
- Yelp
- Forecast
- MTA Info
- Twilio

### Gems:

- Devise
- Twilio-Ruby
- Geocoder
- Yelpster
- HTTParty
- Sanitize
- Nokogiri


<br>
<br>

<img src="/app/assets/images/mom_home_page.png" style="width: 700px">
<br>
<br>

## Code Snippets
<hr>

###API Integration
```

module Api
require 'open-uri'
require 'sanitize'
require 'nokogiri'

  def connect
    @account_sid = ENV["TWILIO_ACCOUNT_SID"]
    @auth_token = ENV["TWILIO_AUTH_TOKEN"]
    @mom_number = ENV["TWILIO_PHONE_NUMBER"]
    @client = Twilio::REST::Client.new @account_sid, @auth_token
  end
  
  def get_restaurants(user)
    Yelp.configure(:yws_id     => ENV["YELP_YWS_ID"],
              :consumer_key    => ENV["YELP_CONSUMER_KEY"],
              :consumer_secret => ENV["YELP_CONSUMER_SECRET"],
              :token           => ENV["YELP_TOKEN"],
              :token_secret    => ENV["YELP_TOKEN_SECRET"]
              )
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
  end
  
  def send_restaurants
    users = User.where(yelp: true)
    users.each do |user|
      if user.yelp_infos == []
        get_restaurants(user)
      end
      restaurants = user.yelp_infos.sample(3).map {|restaurant| "#{restaurant.restaurant_name}\n#{restaurant.address}\n#{restaurant.cuisine_type}\n"}
      @client.account.messages.create(
          :from => ENV["TWILIO_PHONE_NUMBER"],
          :to => user.phone_number,
          :body => "Mom here! With your metabolism you shouldn't eat too much, but here are some nearby restaurants if you're hungry:"
        )
      @client.account.messages.create(
          :from => @mom_number,
          :to => user.phone_number,
          :body => "#{restaurants[0]}\n#{restaurants[1]}\n#{restaurants[2]}"
        )
    end
  end
     
      
  def get_forecast(user)
    forecast_api = ENV["FORECAST_API_KEY"]
    url = "https://api.forecast.io/forecast/#{forecast_api}/#{user.latitude},#{user.longitude}"
    response = JSON.parse(HTTParty.get(url).body)
    temperature = response["currently"]["temperature"]
    summary = response["currently"]["summary"].downcase

    case  
      when temperature < 0 
        return "It's #{temperature} degrees outside and #{summary}. It's freezing outside! Stay home. I'm coming over."
      when temperature < 25 && temperature > 0 
        return "It's #{temperature} degrees outside and #{summary}. You'd better wear that beautiful scarf that I made you that I know you don't like."
      when temperature < 50 && temperature > 25
        return "It's #{temperature} degrees outside and #{summary}. It's chilly, honey. Don't forget your coat or that I'll always love you even though I never hear from you."
      when temperature < 70 && temperature > 50 
        return "It's #{temperature} degrees outside and #{summary}. You might need a light jacket. Oh, and I never liked that person you're dating. They don't deserve you!"
      when temperature > 70 && temperature < 85
        return "It's #{temperature} degrees outside and #{summary}. Oh, it's so nice out it just makes me want to sit and have a glass of white wine and think about every single thing you ever did as a child."
      when temperature > 85
        return "It's #{temperature} degrees outside and #{summary}. This is either the heat or the menopause talking, but I don't think I ever loved your father."
    end
  end

  def send_weather_texts
    users = User.where(weather: true)
    users.each do |user|
      forecast = get_forecast(user)
      @client.account.messages.create(
        :from => @mom_number,
        :to => user.phone_number,
        :body => forecast
      )
    end
  end
```

```
require 'api.rb'
include Api

desc "This task is called by the Heroku scheduler add-on"
task :weather => :environment do
  connect
  puts "Sending weather texts"
  send_weather_texts
  puts "done."
end


desc "This task is for sending an annoying text"
task :annoying => :environment do 
  connect
	puts "Sending an annoying text"
	send_annoying_text
	puts "done."
end

desc "This task is for sending yelp info"
task :yelp => :environment do 
  connect
  puts "Sending Yelp info"
  send_restaurants
  puts "done."
end

desc "This task is for sending mta info"
task :mta => :environment do 
  connect
  puts "Sending MTA info"
  send_mta_text
  puts "done."
end

```

