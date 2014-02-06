require 'api.rb'
include Api

desc "This task is called by the Heroku scheduler add-on"
task :weather => :environment do
  puts "Sending weather texts"
  send_weather_texts
  puts "done."
end

desc "This task is for sending an annoying text"
task :annoying => :environment do 
	puts "Sending an annoying text"
	send_annoying_text
	puts "done."
end

