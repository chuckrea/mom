require 'api.rb'
include Api

desc "This task is called by the Heroku scheduler add-on"
task :weather => :environment do
  puts "Sending weather texts"
  send_weather_texts
  puts "done."
end