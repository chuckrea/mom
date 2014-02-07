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
task :yelp => :environment do 
  connect
  puts "Sending MTA info"
  send_mta_text
  puts "done."
end

