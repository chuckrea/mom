require 'open-uri'
require 'sanitize'
require 'nokogiri'

# # namespace :mta do

#     task :text_em => :environment do
#         url = "https://api.sendhub.com/v1/messages/?username=9177559495\&api_key=5d04b7c26946c768565d4c10b00c11f58ac526a6"
#         @response= HTTParty.post(url, 
#         :body => { :contacts => ['+19177559495'],
#                     :text => 'testing from rake' 
#              }.to_json,
#     :headers => { 'Content-Type' => 'application/json' } )
#         puts @response
#     end


    task :fetch => :environment do

        Line.destroy_all
        
        #Opens and Cleans XML
        filestring = ""
        f = open('http://www.mta.info/status/serviceStatus.txt')
        f.each {|line| filestring += line }
        filestring.gsub!(/&lt;/, "<").gsub!(/&gt;/, ">").gsub!(/&amp;nbsp;/, " ").gsub!(/&amp;/, "")

        #Parse XML
        doc = Nokogiri::HTML(filestring)

        #Returns last update time
        time = doc.xpath('//service//timestamp')
        last_update = Sanitize.clean!("#{time}")

        #RETURNS LINES ARRAY
        lines =[] 
        names = doc.xpath('//subway//name').map {|name| name}
        names.each do |name|
        clean_name = Sanitize.clean!("#{name}")
        lines << clean_name
        end

        #RETURNS STATUS ARRAY
        line_status = []
        status = doc.xpath('//subway//name').map {|name| name.next_sibling.text}
        status.each do |status|
        line_status << status
        end

        #RETURNS DESCRIPTION ARRAY
        status_description = doc.xpath('//subway//name').map {|name| name.next_sibling.next_sibling.text.split("\n").drop(2)}

        description =[]
        status_description.each do |status|
        description << status.join.split.join(" ")
        end

        lines.each_with_index do |thing, index|
            Line.create(name: lines[index], status: status[index], description: description[index])
        end

    end

# end