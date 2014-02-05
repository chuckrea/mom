require 'api.rb'

desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Sending weather texts"
  send_weather_texts
  puts "done."
end