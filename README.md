# Mom.com
***"Because I never liked that Siri and I just don't think she's good enough for you!"***

##Description
<hr>
A slightly passive aggressive text based reminder service providing users with location specific forecasts, restaurant recommendations and transportation updates.


##API's and Gems
<hr>
### Yelp
### Forecast
### MTA Info
###Twilio

- Devise
- Twilio-Ruby
- Geocoder
- Yelpster
- HTTParty
- Sanitize
- Nokogiri


<br>
<br>

<img src="/Users/DanielBushkanets/Desktop/Screen Shot 2014-02-07 at 9.51.33 AM.png" style="width: 300px">
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

