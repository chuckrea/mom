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

## Code Snippet
<hr>

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

