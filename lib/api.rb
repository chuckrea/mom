module Api
require 'open-uri'
require 'sanitize'
require 'nokogiri'

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
        @lines =[] 
        names = doc.xpath('//subway//name').map {|name| name}
        names.each do |name|
        clean_name = Sanitize.clean!("#{name}")
        @lines << clean_name
        end

        #RETURNS STATUS ARRAY
        line_status = []
        @status = doc.xpath('//subway//name').map {|name| name.next_sibling.text}
        @status.each do |status|
        line_status << status
        end

        #RETURNS DESCRIPTION ARRAY
        status_description = doc.xpath('//subway//name').map {|name| name.next_sibling.next_sibling.text.split("\n").drop(2)}

        description =[]
        status_description.each do |status|
        description << status.join.split.join(" ")
        end

        puts @lines
        puts "***********************************"

        puts @status
        puts "***********************************"

  def get_farmersmarkets(user)

    # ZIP - data info
      url = "https://data.ny.gov/resource/farmersmarkets.json?zip=#{user.zip_code}"
      response = HTTParty.get(url)
      farmersmarkets = JSON(response.body)

      farmersmarkets.each do |market|
        mkt = FarmersMarket.create(location: market["location"], market_name: market["market_name"], operation_hours: market["operation_hours"])
        user.farmers_markets << mkt
      end
  end

  def get_restaurants(user)

    Yelp.configure(:yws_id     => '55vsTZcAU8kH_LEQj_oIjA',
              :consumer_key    => 'I7sXrBiqGJXGNmZGMeOiJQ',
              :consumer_secret => 'JdMoZU8iGn6iQlvuP2Mk5-EsPt8',
              :token           => '-_031yEPjKzFSJuzTovFdp0M5RufpYC1',
              :token_secret    => 'USpbVVJmAEWq_m4mykUJbcK4kNc')


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
    # # Name
    # name = response["businesses"][0]["name"]
    # # Address
    # address = response["businesses"][0]["location"]["display_address"]
    # # Category
    # category = response['businesses'][0]["categories"][1][0]

  end

  def send_restaurants(user)
    account_sid = 'AC2e3cd4670d5a455fb0e6da2e5ddd5eeb'
    auth_token = 'b40b07ba1a2d3d92bb5e9e2c77330c3b'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    restaurants = user.yelp_infos.sample(3).map {|restaurant| "#{restaurant.restaurant_name}\n#{restaurant.address}\n#{restaurant.cuisine_type}"}
    @client.account.messages.create(
        :from => '+16463623890',
        :to => user.phone_number,
        :body => "Mom here! With your metabolism you shouldn't eat too much, but here are some nearby restaurants if you're hungry:"
      )
    @client.account.messages.create(
        :from => '+16463623890',
        :to => user.phone_number,
        :body => "#{restaurants[0]}\n#{restaurants[1]}\n#{restaurants[2]}"
      )

      
  end

  def get_forecast(user)
    url = "https://api.forecast.io/forecast/b20ed2cf518265035a434036f7522627/#{user.latitude},#{user.longitude}"
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

  def get_mta(user)
    @mta_status = @status[@lines.index(user.line)]
    puts @status
    puts @lines
  end 

  def send_weather_texts

    account_sid = 'AC2e3cd4670d5a455fb0e6da2e5ddd5eeb'
    auth_token = 'b40b07ba1a2d3d92bb5e9e2c77330c3b'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    users = User.all
    users.each do |user|
      forecast = get_forecast(user)
      @client.account.messages.create(
        :from => '+16463623890',
        :to => user.phone_number,
        :body => forecast
      )
    end
  end

  def send_mta_text
    account_sid = 'AC2e3cd4670d5a455fb0e6da2e5ddd5eeb'
    auth_token = 'b40b07ba1a2d3d92bb5e9e2c77330c3b'
    
    @client = Twilio::REST::Client.new account_sid, auth_token

    users = User.all
    users.each do |user|
      line_status = get_mta(user)
      @client.account.messages.create(
        :from => '+16463623890',
        :to => user.phone_number,
        :body => line_status 
      )
    end
  end
end
